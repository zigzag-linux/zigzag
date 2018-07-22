# zigzag-images

Kiwi build descriptions of Zigzag Linux images

## Building

        $ ./build.sh

Build runs inside of a Docker container, once done the output iso will be located in `out/` directory. **Before running the script make sure that Docker daemon is running and user has sufficient permissions.**

## Variants

By default the build command will pick up stable Leap, there is however an option to build against different base versions and enabling [development repository](https://build.opensuse.org/project/show/home:mkrwc:zigzag:devel).

| Name               | openSUSE Version | Devel repo enabled   |
|--------------------|------------------|----------------------|
| leap-stable        | Leap             | No                   |
| leap-devel         | Leap             | Yes                  |
| tumbleweed-devel   | Tumbleweed       | Yes                  |

To build Tumbleweed with development repo:

        $ ./build.sh tumbleweed-devel
