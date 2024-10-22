# -*- coding: utf-8 -*-

ID_MAX = 2 ** 31 - 1

import re

def validate_graph_definition(lines):
  vertex_edge_match = re.match(r'^(\d+) (\d+)$', lines[0])
  if not vertex_edge_match:
    return False, "First line must contain two integers (|V| and |E|).", None

  V, E = int(vertex_edge_match.group(1)), int(vertex_edge_match.group(2))
  if not (1 <= V <= 100 and (V - 1) <= E <= V * (V - 1) / 2):
    return False, "|V| and |E| are out of the allowed range.", None

  edges_seen = set()
  vertices = set()
  for line in lines[1:E + 1]:
    parts = line.split()
    if len(parts) != 4:
      return False, "Edge line format is incorrect.", None

    u, v, b, c = map(int, parts)
    if not (1 <= u <= V and 1 <= v <= V and 1 <= b <= 100 and 1 <= c <= 100):
      return False, "Edge vertices or weights are out of the allowed range.", None

    edge = tuple(sorted([u, v]))
    if edge in edges_seen:
      return False, f"Duplicate edge found: {edge}", None
    edges_seen.add(edge)

    vertices.add(u)
    vertices.add(v)

  if len(vertices) != V:
    return False, "Graph is not connected.", None

  return True, "Graph definition is valid.", vertices

def validate_function_calls(lines, vertices, file_name):
  insert_pattern = re.compile(r'^insert (\d+) (\d+) \{([\d ]+)\} (\d+)$')
  stop_pattern = re.compile(r'^stop (\d+)$')
  rearrange_pattern = re.compile(r'^rearrange$')

  function_count = 0
  active_inserts = set()
  all_inserts = set()
  valid_insert_generated = False  # Track if a valid insert call has been encountered

  for line in lines:
    function_count += 1

    if match := insert_pattern.match(line):
      id, s, D, _ = match.groups()
      id, s = int(id), int(s)
      if id in all_inserts:
        return False, "Duplicated insert IDs"
      
      if id <= 0 or id > ID_MAX:
        return False, "Insert ID out of range"

      D_vertices = set(map(int, D.split()))
      if s not in vertices:
        return False, f"Invalid insert function ({line}), source not in V."

      if not D_vertices.issubset(vertices):
        return False, f"Invalid insert function ({line}), D not a subset of V."

      if file_name == 'Problem1_test_case.txt' and D_vertices != vertices:
        return False, "In Problem 1, D must contain all vertices in V."

      active_inserts.add(id)
      all_inserts.add(id)
      valid_insert_generated = True

    elif match := stop_pattern.match(line):
      id = int(match.group(1))
      if id not in active_inserts:
        return False, "Stopping a non-existent or already stopped insert."
      active_inserts.remove(id)

    elif rearrange_pattern.match(line):
      if not valid_insert_generated:
        return False, "Rearrange function call cannot appear before any valid insert call."
    else:
      return False, "Function call format is incorrect."

  if not (2 <= function_count <= 100000):
    return False, f"Number of function calls ({function_count}) is out of the allowed range."

  return True, "Function calls are valid."

def validate_test_case(file_name):
  try:
    with open(file_name, 'r') as file:
      lines = file.read().strip().split('\n')
  except FileNotFoundError:
    return False, f"File {file_name} not found."

  try:
    blank_line_index = lines.index('')
    graph_lines = lines[:blank_line_index]
    function_lines = lines[blank_line_index + 1:]
  except ValueError:
    return False, "File does not contain a blank line separating graph definition and function calls."

  valid_graph, graph_message, vertices = validate_graph_definition(graph_lines)
  if not valid_graph:
    return False, graph_message

  valid_functions, function_message = validate_function_calls(function_lines, vertices, file_name)
  if not valid_functions:
    return False, function_message

  return True, "Test case is valid."


file_names = ['Problem1_test_case.txt', 'Problem2_test_case.txt']
for file_name in file_names:
  is_valid, message = validate_test_case(file_name)
  if is_valid:
    print(f"{file_name}: {message}")
  else:
    print(f"{file_name}: Error - {message}")

