# TODO

## Bug

- [x] **Fix the random index going past the end of the lists** (`namegen.cc`, end of `main`).
  `std::uniform_int_distribution<> dis_left(1, left.size())` (and `dis_right`) draws from
  `[1, size]`, but valid indexes are `[0, size-1]`.
  - When the draw equals `size`, the program reads past the end of the vector (undefined
    behavior). A libc++ build with bounds checking crashed on run 225 of 3,000 with
    `vector[] index out of bounds`.
  - Index 0 can't be drawn, so `"admiring"` and `"agnesi"` never appear.
  - Fix: use `(0, size - 1)`, ideally with `std::size_t` and no `static_cast<int>`.

## Code quality

- [x] Use one seeded `std::mt19937` for both picks instead of two `random_device`s and two engines.
- [x] Add `#include <string>`. No longer needed: the lists are `std::string_view`, and
      `<string_view>` is included instead.
- [x] Make the word lists `static constexpr std::string_view[]` so about 350 `std::string`s
      aren't built on every run. Drop the leftover `{{ ... }}` double braces.
- [x] Update the stale header comment: the build line says `-std=c++14` and `names.cc`.
- [x] Re-sort the lists. Entries out of place were `cool`, `interesting` and `mystifying`
      (left) and `curran`, `hellman`, `meitner`, `murdock` and `rhodes` (right).
- [x] Reroll `boring_wozniak` like moby does.

## Build and CI

- [x] In `CMakeLists.txt`, use `target_compile_options(namegen PRIVATE -Wall -Wextra -pedantic)`
      instead of overwriting `CMAKE_CXX_FLAGS`, which replaces flags the user passes in.
      Add `set(CMAKE_CXX_STANDARD_REQUIRED ON)`.
- [x] Add at least one real test with `add_test`. `tests/run_namegen.cmake` runs namegen
      1,000 times and checks the exit status, stderr and output format.
- [x] Add a sanitizer build to CI (`-DNAMEGEN_SANITIZE=ON`). It catches the original
      out-of-bounds bug; a plain Release build does not.
- [x] Update the workflow: move to `actions/checkout@v7`, remove the template's boilerplate
      comments, and build and test on Ubuntu, macOS and Windows.
- [x] Remove the Makefile and keep only CMake.

## Docs

- [ ] Expand `README.md`: where the word lists come from (moby, Apache-2.0), how to build and run,
      and sample output.
- [ ] Check that `LICENSE` is compatible with including moby's lists, and add attribution if needed.
