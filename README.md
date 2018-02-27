# zigzag-images

Kiwi build descriptions of Zigzag Linux images

## Building

        $ ./build.sh

Build runs inside of a Docker container, once done the output iso will be located in `out/` directory. **Before running the script make sure that Docker daemon is running and user has sufficient permissions.**

## Variants

By default the build command will pick up stable Leap, there is however an option to build against different base versions and enabling [testing repostory](https://build.opensuse.org/project/show/home:mkrwc:zigzag:testing).

| Name               | openSUSE Version | Testing repo enabled |
|--------------------|------------------|----------------------|
| leap-stable        | Leap             | No                   |
| leap-testing       | Leap             | Yes                  |
| tumbleweed-stable  | Tumbleweed       | No                   |
| tumbleweed-testing | Tumbleweed       | Yes                  |

To build Tumbleweed with testing repo:

        $ ./build.sh tumbleweed-testing
