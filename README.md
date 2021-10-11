# curation-dev-jupyter-challenge
Welcome to the All of Us Curation Team's Jupyter Notebook challenge!  This challenge is designed to test some basic
skills across a variety of areas you will be expected to interact with as a member of our team.  Our hope is that you
will find this an interesting, and hopefully educational, little exercise.

## Environment Expectations
Before we get to the challenge itself, we have a few high-level expectations we require out of any response.

### 1. Database
Unless explicitly specified in your challenge email, you are free to use whatever DB engine you wish.  If you are asked
to use a certain DB engine, you must complete the challenge with the specified engine

Additionally, you must not add the database state to your submission.  As an example, no `sqlite.db` file or postgres
`pgdata` directory may be checked in.  The same applies for all other types of databases.

### 2. Docker
It is expected that you are able to run [Docker](https://docs.docker.com/get-docker/) and
[Docker Compose](https://docs.docker.com/compose/install/) to perform the initial step of this challenge.

Additionally, it is expected that your chosen database will run as a container.  You must define either a 
[Dockerfile](https://docs.docker.com/engine/reference/builder/) or a
[Docker Compose](https://docs.docker.com/compose/compose-file/compose-file-v3/) file that, when run, launches and
initializes said database with the output from step 1 of the challenge.

### 3. Jupyter
You will be expected to provide a [Jupyter Notebook](https://jupyter.org/) file that uses the aforementioned database
as its data source.  It does not have to be run from a container, but it certainly can be.

## The Challenge
1. From the root of this challenge directory, execute:
   ```shell
   # on Linux and macOS
   ./generate_csv.sh
   # on Windodws
   .\\generate_csv.ps1
   ```
   * This creates a file named `python-github-repos.csv` within the `./repos-csv-output` directory.
2. Store this data in the database engine either requested of you, or of your choice if left open.
3. Create a Jupyter Notebook that connects to this database and provides visualizations of this data of your own 
choosing
   * Multiple visualizations must be provided, and you must be able to explain why you chose a given visualization for
a given data model 
4. Where applicable, the user must be able to alter the data used in a given visualization, either by number of items
being displayed, data points being represented, or anything that you feel may make sense / be interesting!
5. Create a `RESPONSE_README.md` file with the following:
   1. Explanation of database initialization process
   2. Explanation of how to run your database container and notebook
   3. Description of basic workflow of challenge response
   4. Description of visualizations chosen and any / all selectable options per visualization