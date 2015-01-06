# Cloverfield Build w/ Makefiles

An example of building a project with `make`, based on the [TodoMVC backbone
example](https://github.com/tastejs/todomvc/tree/gh-pages/examples/backbone).

## Getting Started

```bash
git clone https://github.com/jesstelford/cloverfield-build-make.git && cd cloverfield-build-make
npm install
```

## Build process

To run the build process

```bash
make
```

Available make targets can be seen in `Makefile`;

```
all   - alias for make lint build test
build - alias for make css js
js    - concat + compress js files
css   - convert scss to css
lint  - use eslint to check correctness of js files
test  - run tape tests as present in test/ dir
clean - clean up after previously run build targets
```

Note that the `css` target really doesn't do anything - it is a contrived
example for this repo and merely results in copying an existing `.css` file to
another location (it was never Sass to begin with!)

### `npm run` aliases

I have aliased a couple of the commands in `package.json` as runnable scripts.
This is done as an example showing how `make` and `npm` can live in harmony.

```bash
npm run build-all   # alias for make lint build test
npm run build-clean # alias for make clean
```

## Motivation

> Cloverfield aims to create a next generation JavaScript project boilerplate.
> That means we'll use the tools that coders in-the-know will be using over the
> next 1 - 3 years. We're starting with the 2016 edition. Read more.
> 
> The JS community has been splintering when it comes to task runner consensus.
> For a while, Grunt was the clear winner, but that isn't the case anymore. We
> need to make a decision on one of these options, because many of our
> generators are going to produce some sort of task runner config. Please do
> some research and weigh in by answering the questions below.
> 
> Gulp and Brocolli have entered the community radar, and there is a growing
> trend to lean more heavily on Unix pipes instead of Node streams or the heavy
> file i/o typical of Grunt setups.
> 
> And the long-time reigning champion that's been a part of Unix since the time
> of the ancient grey beards is starting to make inroads. See Building
> JavaScript Projects with Make.
> 
> Oh, and npm has a built-in task runner that lets you easily leverage Unix
> pipes. Substack thinks that's the way to go, and he's not alone.
> 
> This is a pretty confusing landscape for those who haven't investigated all of
> these possible solutions, so lets try to lay out the pros and cons of each.

- [Choosing a Task Runner for the Cloverfield Boilerplate
  Scaffold](https://github.com/ericelliott/cloverfield/issues/2)
