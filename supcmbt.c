#include <stdio.h>
#include <stdlib.h>
#include <tgi.h>
#include <conio.h>

extern const char text[];

int main (void) {
  unsigned char border;

  tgi_load_driver(tgi_stddrv);
  tgi_init();

  border = bordercolor(COLOR_BLACK);
  //bgcolor(COLOR_BLACK);

  tgi_clear();

  //tgi_settextstyle(1, 1, TGI_TEXT_HORIZONTAL, TGI_FONT_VECTOR);

  tgi_setdrawpage(1);
  tgi_setviewpage(1);

  tgi_setcolor(COLOR_WHITE);

  tgi_gotoxy(0, 0);
  tgi_lineto(tgi_getmaxx(), 0);
  tgi_lineto(tgi_getmaxx(), tgi_getmaxy());
  tgi_lineto(0, tgi_getmaxy());
  tgi_lineto(0, 0);

  tgi_gotoxy(10, 10);
  tgi_outtext(text);

  while (!kbhit()) {
  }
  cgetc();

  tgi_unload();

  bordercolor(border);

  return EXIT_SUCCESS;
}
