#ifndef GLW_H
#define GLW_H

#include <GL/gl.h>

/*--------------------------------------------------------------------*/

#define GLW_CLOSE	 2
#define GLW_RENDER	 3
#define GLW_RESIZE	 4

#define GLW_MOTION	 5
#define GLW_L_BTN_D	 6
#define GLW_L_BTN_U	 7
#define GLW_M_BTN_D	 8
#define GLW_M_BTN_U	 9
#define GLW_R_BTN_D	10
#define GLW_R_BTN_U	11
#define GLW_WHEEL_D	12
#define GLW_WHEEL_U	13
#define GLW_KEY_D	14
#define GLW_KEY_U	15

/*--------------------------------------------------------------------*/

int  glw_create(const char *, int, int, int);
void glw_delete(void);

void glw_acquire(void);
void glw_release(void);

int  glw_update(int, int);

int  glw_x(void);
int  glw_y(void);

/*--------------------------------------------------------------------*/

#endif
