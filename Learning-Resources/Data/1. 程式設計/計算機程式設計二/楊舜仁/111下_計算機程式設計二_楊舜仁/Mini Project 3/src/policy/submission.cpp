#include <cstdlib>
#include <limits.h>
#include <cmath>

#include "../state/state.hpp"
#include "./submission.hpp"


/**
 * @brief Randomly get a legal action
 * 
 * @param state Now state
 * @param depth You may need this for other policy
 * @return Move 
 */

int countSubmission(State* state, int depth, bool maxPlayer, int alpha, int beta);

Move Submission::get_move(State *state, int depth){
  if(!state->legal_actions.size())
    state->get_legal_actions();

  int hScore = -1000000;
  Move rt = *state->legal_actions.begin();
  for (Move ns : state->legal_actions) {
    State* newState = state->next_state(ns);
    int result = countSubmission(newState, depth, false, -1500000, 1500000);
    if (result >= hScore) {
      hScore = result;
      rt = ns;
    }
  }
  
  return rt;
}

int countSubmission(State* state, int depth, bool maxPlayer, int alpha, int beta) {
  if(!state->legal_actions.size())
    state->get_legal_actions();

  if (state->game_state == WIN && maxPlayer)
    return 5000000;
  else if (state->game_state == WIN && !maxPlayer)
    return -5000000;

  
  if (depth == 0) {
    return state->evaluate(maxPlayer);
  }


  if (maxPlayer) {
    int rt = -1000000;
    for (auto ns : state->legal_actions) {
      State* newState = state->next_state(ns);
      int result = countSubmission(newState, depth, false, alpha, beta);
      rt = std::max(rt, result);
    }
    return rt;
  }
  else {
    int rt = 1000000;
    for (auto ns : state->legal_actions) {
      State* newState = state->next_state(ns);
      int result = countSubmission(newState, depth - 1, true, alpha, beta);
      rt = std::min(rt, result);
    }
    return rt;
  }
}