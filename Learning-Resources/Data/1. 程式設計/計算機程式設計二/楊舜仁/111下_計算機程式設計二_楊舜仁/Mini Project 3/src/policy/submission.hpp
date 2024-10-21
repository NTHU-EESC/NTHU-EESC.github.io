#pragma once
#include "../state/state.hpp"


/**
 * @brief Policy class for alphabeta policy.
 */
class Submission{
public:
  static Move get_move(State *state, int depth);
};