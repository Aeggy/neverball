#ifndef COIN_H
#define COIN_H

#include <GL/gl.h>
#include <sol.h>

GLuint coin_init(int);
void   coin_draw(GLuint, const struct s_coin *, int, int);
int    coin_test(const struct s_ball *, struct s_coin *, int);

#endif
