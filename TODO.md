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
- [ ] Add `#include <string>`. It currently compiles only because `<iostream>` pulls it in.
- [ ] Make the word lists `static const std::array<std::string_view, N>` (or `constexpr`) so
      about 350 `std::string`s aren't built on every run. Drop the leftover `{{ ... }}` double braces.
- [ ] Update the stale header comment: the build line says `-std=c++14` and `names.cc`.
- [ ] Re-sort the lists: `compassionate` (left) and `curie` (right) are out of alphabetical order.
- [ ] Optional: reroll `boring_wozniak` like moby does.

## Build and CI

- [ ] In `CMakeLists.txt`, use `target_compile_options(namegen PRIVATE -Wall -Wextra -pedantic)`
      instead of overwriting `CMAKE_CXX_FLAGS`, which replaces flags the user passes in.
      Add `set(CMAKE_CXX_STANDARD_REQUIRED ON)`.
- [ ] Add at least one real test with `add_test`. Right now `ctest` runs nothing and always passes.
- [ ] Add a sanitizer or hardened build to CI (it would have caught the bug above).
- [ ] Update the workflow: move to `actions/checkout@v4` or later and remove the template's
      boilerplate comments. Optionally add a matrix to build on macOS and Windows too.
- [ ] Makefile: use `CXX`/`CXXFLAGS`, rely on the built-in rule instead of the custom `.cc:` rule,
      use `rm -f` in `clean`, and reconsider running `strip` on every build. Or drop the Makefile
      and keep only CMake.

## Docs

- [ ] Expand `README.md`: where the word lists come from (moby, Apache-2.0), how to build and run,
      and sample output.
- [ ] Check that `LICENSE` is compatible with including moby's lists, and add attribution if needed.
