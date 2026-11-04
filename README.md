# namegen

Generate a random name in the style of Docker's container names: an adjective
followed by the surname of a notable scientist or engineer.

```console
$ ./build/namegen
kind_blackwell
$ ./build/namegen
gifted_wozniak
$ ./build/namegen
charming_swartz
```

## Building

namegen needs CMake 3.13 or later and a C++17 compiler.

```sh
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release
```

The binary is `build/namegen` (`build/Release/namegen.exe` with Visual Studio).

## Testing

```sh
ctest --test-dir build -C Release --output-on-failure
```

The test runs namegen 1,000 times and checks that every run exits cleanly and
prints one well-formed name.

To build and test with the address and undefined behavior sanitizers (GCC or
Clang):

```sh
cmake -B build-sanitize -DCMAKE_BUILD_TYPE=Debug -DNAMEGEN_SANITIZE=ON
cmake --build build-sanitize
ctest --test-dir build-sanitize --output-on-failure
```

## Credits and license

The word lists, and the comments describing each person, come from
[moby's name generator](https://github.com/moby/moby/blob/v20.10.13/pkg/namesgenerator/names-generator.go)
and are licensed under the Apache License, Version 2.0. See
[THIRD_PARTY_NOTICES](THIRD_PARTY_NOTICES).

Everything else is licensed under the MIT License. See [LICENSE](LICENSE).
