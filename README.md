# C Project Template

This template provides everything you need to start a new C project. It supports essential features, such as:

 * [Make](https://www.gnu.org/software/make/) support for building application, libraries and tests
 * [Doxygen](http://www.doxygen.nl/) support for documenting
 * [Unity](http://www.throwtheswitch.org/unity/) support for unit testing
 * [Travis CI](https://travis-ci.com/) support for CI/CD

## Getting Started

### Prerequisites

To build the sample project from source, the following tools are needed:

 * make
 * gcc

On Ubuntu/Debian, you can install them with:

```shell
  sudo apt-get install build-essential
```

On other platforms, please use the corresponding package managing tool to
install them before proceeding.

### Installing

You can get the source by "git clone" this git repository.

```shell
  git clone https://github.com/jballoffet/c-template.git
```

To build the sample application execute the following:

```shell
  cd c-template
  make
```

To run the sample application execute the following:

```shell
  ./bin/app.out
```
You should see something like this:

```
  Hello World!
  foo.c -> bar(): 1
  libbaz.a -> qux(): 2
```

## Running the tests

This template supports Unity for unit testing, and includes one test to show how to use it. To build and run the tests execute the following:

```shell
  make test
```

You should see something like this:

```
  Hello World!
  foo.c -> bar(): 1
  libbaz.a -> qux(): 2
```

To run the tests again without re-building, execute:

```shell
  ./bin/test/test.out
```

## Contributing

Please read [CONTRIBUTING.md](/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/jballoffet/c-template/tags). 

## Authors

* **Javier Balloffet** - *Initial work* - [jballoffet](https://github.com/jballoffet)

See also the list of [contributors](https://github.com/jballoffet/c-template/contributors) who participated in this project.

## License

This project is licensed under the Apache 2.0 License - see the [LICENSE](/LICENSE) file for details

[Unity](http://www.throwtheswitch.org/unity/) is
distributed under the MIT license. See [LICENSE.txt](/test/unity/LICENSE.txt) for details.
