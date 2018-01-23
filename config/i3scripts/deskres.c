/*
   Tool to get and print displays resolutions
   gcc -I /usr/include/SDL2 -lSDL2 -o deskres deskres.c
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "SDL.h"

// query the system and get the current display mode for the specified screen
SDL_DisplayMode *get_current_display_mode(unsigned int currentDisplay)
{
  // this screen
  SDL_DisplayMode *screenMode;
  screenMode = (SDL_DisplayMode *)malloc(sizeof(SDL_DisplayMode));

  // query the graphic subsystem
  if (SDL_GetCurrentDisplayMode(currentDisplay, screenMode) != 0)
  {
    // error during query, report please
    return NULL;
  }

  // ok, screen info retrieved
  return screenMode;
}

// main entrypoint
int main(int argc, char* argv[])
{
  // getopt related veriables
  int opt, monitorIndex;
  int m=0, w=0, h=0;

  // Declare display mode structure to be filled in.
  SDL_DisplayMode *current;

  while((opt = getopt(argc, argv, "i:wh")) != -1) {
    switch(opt){
      case 'i':
        monitorIndex = atoi(optarg);
        m = 1;
        break;
      case 'w':
        w = 1;
        break;
      case 'h':
        h = 1;
        break;
      default:
        exit(EXIT_FAILURE);
    }
  }

  // check options
  if ((m == 0)||!(w^h)) {
    fprintf(stderr, "Syntax Error.\n");
    fprintf(stderr, "Usage: %s -i <monitor index> [-w|-h]\n", argv[0]);
    exit(EXIT_FAILURE);
  }

  // init the SDL video subsystem
  SDL_Init(SDL_INIT_VIDEO);

  // query graphics subsystem
  current = get_current_display_mode(monitorIndex);
  if (w) {
    fprintf(stdout, "%d", current->w);
  } else if (h) {
    fprintf(stdout, "%d", current->h);
  } else {
    SDL_Log("Monitor index: %d -> Width: %d Height: %d, Refresh: %dHz", monitorIndex, current->w, current->h, current->refresh_rate);
  }

  // Clean up and exit the program.
  SDL_Quit();
  return 0;
 }
