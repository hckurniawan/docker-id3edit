# docker-id3edit
Dockerfile to create id3edit image

## What
id3edit is a command line tool to edit and debug ID3v2 tags of mp3 files supporting Unicode.
This repository contain Dockerfile definition to build Docker image [https://hub.docker.com/r/hckurniawan/id3edit](https://hub.docker.com/r/hckurniawan/id3edit)

## License
* id3edit's license is [GNU General Public License v3.0](https://github.com/rstemmer/id3edit/blob/v2.1.3/LICENSE).
* License for this repository is [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html)

## Resources
* [id3edit GitHib](https://github.com/rstemmer/id3edit).

## Usage
### To use Docker image
```
docker run --rm -it \
  -v $(pwd):/work \
  -w "/work" \
  hckurniawan/id3edit id3edit "$@"
```
### Use id3edit
See [id3edit GitHub](https://github.com/rstemmer/id3edit#usage) for usage and example
