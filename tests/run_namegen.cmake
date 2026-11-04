# Runs namegen repeatedly and checks that each run exits cleanly and prints
# a single adjective_surname line.
#
# Usage: cmake -DNAMEGEN=<path to namegen> [-DRUNS=<count>] -P run_namegen.cmake

if (NOT NAMEGEN)
  message(FATAL_ERROR "NAMEGEN must be set to the namegen executable")
endif()
if (NOT RUNS)
  set(RUNS 1000)
endif()

foreach (i RANGE 1 ${RUNS})
  execute_process(COMMAND "${NAMEGEN}"
                  RESULT_VARIABLE result
                  OUTPUT_VARIABLE output
                  ERROR_VARIABLE error)
  if (NOT result EQUAL 0)
    message(FATAL_ERROR "run ${i}: exited with '${result}'\n${error}")
  endif()
  if (NOT error STREQUAL "")
    message(FATAL_ERROR "run ${i}: unexpected stderr:\n${error}")
  endif()
  if (NOT output MATCHES "^[a-z]+_[a-z]+\r?\n$")
    message(FATAL_ERROR "run ${i}: unexpected output: '${output}'")
  endif()
  if (output MATCHES "^boring_wozniak")
    message(FATAL_ERROR "run ${i}: Steve Wozniak is not boring")
  endif()
endforeach()
