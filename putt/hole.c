/*   
 * Copyright (C) 2003 Robert Kooima
 *
 * NEVERPUTT is  free software; you can redistribute  it and/or modify
 * it under the  terms of the GNU General  Public License as published
 * by the Free  Software Foundation; either version 2  of the License,
 * or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT  ANY  WARRANTY;  without   even  the  implied  warranty  of
 * MERCHANTABILITY or  FITNESS FOR A PARTICULAR PURPOSE.   See the GNU
 * General Public License for more details.
 */

#include <stdio.h>
#include <string.h>
#include <math.h>

#include "hole.h"
#include "glext.h"
#include "image.h"
#include "game.h"
#include "geom.h"
#include "hud.h"
#include "back.h"
#include "audio.h"
#include "config.h"

/*---------------------------------------------------------------------------*/

struct hole
{
    char   file[MAXSTR];
    char   back[MAXSTR];
    char   song[MAXSTR];
    int    par;
};

static int hole;
static int party;
static int player;
static int count;
static int done;

static int         stat_v[MAXPLY];
static double      ball_p[MAXPLY][3];
static double      ball_e[MAXPLY][3][3];
static struct hole hole_v[MAXHOL];
static int        score_v[MAXHOL][MAXPLY];

/*---------------------------------------------------------------------------*/

static void hole_init_rc(void)
{
    FILE *fin = fopen(HOLE_FILE, "r");

    hole   = 0;
    player = 0;
    count  = 0;
    done   = 0;

    /* Load the holes list. */

    if (fin)
    {
        while (fscanf(fin, "%s %s %d %s",
                       hole_v[count].file,
                       hole_v[count].back,
                      &hole_v[count].par,
                       hole_v[count].song) == 4)
            count++;

        fclose(fin);
    }
}

/*---------------------------------------------------------------------------*/

void hole_init(void)
{
    int i;

    memset(hole_v,  0, sizeof (struct hole) * MAXHOL);
    memset(score_v, 0, sizeof (int) * MAXPLY * MAXHOL);

    hole_init_rc();

    for (i = 0; i < count; i++)
        score_v[i][0] = hole_v[i].par;
}

void hole_free(void)
{
    game_free();
    back_free();

    count = 0;
}

/*---------------------------------------------------------------------------*/

char *hole_player(int p)
{
    if (p == 0)               return "Par";

    if (p == 1 && 1 <= party) return "P1";
    if (p == 2 && 2 <= party) return "P2";
    if (p == 3 && 3 <= party) return "P3";
    if (p == 4 && 4 <= party) return "P4";

    return NULL;
}

char *hole_score(int h, int p)
{
    static char str[MAXSTR];

    if (1 <= h && h <= hole)
    {
        if (h <= hole && 0 <= p && p <= party)
        {
            sprintf(str, "%d", score_v[h][p]);
            return str;
        }
    }
    return NULL;
}

char *hole_tot(int p)
{
    static char str[MAXSTR];

    int h, T = 0;

    if (p <= party)
    {
        for (h = 1; h <= hole && h <= 18; h++)
            T += score_v[h][p];

        sprintf(str, "%d", T);

        return str;
    }
    return NULL;
}

char *hole_out(int p)
{
    static char str[MAXSTR];

    int h, T = 0;

    if (p <= party)
    {
        for (h = 1; h <= hole && h <= 9; h++)
            T += score_v[h][p];

        sprintf(str, "%d", T);

        return str;
    }
    return NULL;
}

char *hole_in(int p)
{
    static char str[MAXSTR];

    int h, T = 0;

    if (hole > 9 && p <= party)
    {
        for (h = 10; h <= hole && h <= 18; h++)
            T += score_v[h][p];

        sprintf(str, "%d", T);

        return str;
    }
    return NULL;
}

/*---------------------------------------------------------------------------*/

int curr_hole(void)   { return hole;   }
int curr_party(void)  { return party;  }
int curr_player(void) { return player; }
int curr_count(void)  { return count;  }

/*---------------------------------------------------------------------------*/

void hole_goto(int h, int p)
{
    int i;

    if (h >= 0) hole  = h;
    if (p >= 0) party = p;

    player = (hole - 1) % party + 1;
    done   = 0;

    back_init(hole_v[hole].back, 1);
    game_init(hole_v[hole].file);

    for (i = 1; i <= party; i++)
    {
        game_get_pos(ball_p[i], ball_e[i]);
        stat_v[i] = 0;
    }
    game_ball(player);
    hole_song();
}

int hole_next(void)
{
    if (done == party)
    {
        if (hole + 1 < count)
        {
            hole++;

            game_free();
            back_free();

            hole_goto(hole, party);
        }
        else return 0;
    }
    else
    {
        do
        {
            player = player % party + 1;
        }
        while (stat_v[player]);

        game_ball(player);
        game_get_pos(ball_p[player], ball_e[player]);
    }
    return 1;
}

void hole_goal(void)
{
    score_v[hole][player]++;

    if (score_v[hole][player] == 1)
        audio_play(AUD_ONE, 1.0f);

    else if (score_v[hole][player] == score_v[hole][0] - 2)
        audio_play(AUD_EAGLE, 1.0f);
    else if (score_v[hole][player] == score_v[hole][0] - 1)
        audio_play(AUD_BIRDIE, 1.0f);
    else if (score_v[hole][player] == score_v[hole][0])
        audio_play(AUD_PAR, 1.0f);
    else if (score_v[hole][player] == score_v[hole][0] + 1)
        audio_play(AUD_BOGEY, 1.0f);
    else if (score_v[hole][player] == score_v[hole][0] + 2)
        audio_play(AUD_DOUBLE, 1.0f);
    else
        audio_play(AUD_SUCCESS, 1.0f);

    stat_v[player] = 1;
    done++;

    if (done == party)
        audio_music_fade(2.0f);
}

void hole_stop(void)
{
    score_v[hole][player]++;
}

void hole_fall(void)
{
    audio_play(AUD_PENALTY, 1.0f);

    game_set_pos(ball_p[player], ball_e[player]);
    score_v[hole][player] += 2;
}

/*---------------------------------------------------------------------------*/

void hole_song(void)
{
    audio_music_play(hole_v[hole].song);
}
