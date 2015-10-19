# docker-moodle
Simple Docker container for Moodle. Unlike some others, provides OOTB xdebug and mailcatcher support,
and also does not include a mysql server in the Dockerfile; helpful default docker-compose.yml file uses 
the mysql Docker image.

Moodle is imported using a git submodule. Currently at `v2.9.2`.

## Contributing
Issues and pull requests welcome. This is mostly to help others who have found the existing Moodle Dockerfiles
to be too heavy or too tightly integrated with specific use-cases.
