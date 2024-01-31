# hmpps-python-deps

Docker image containing Python dependencies to enable running of Python scripts without needing to install locally. Dependencies included are defined in the [requirements.txt](./requirements.txt) file. Add further dependencies to the [requirements.txt](./requirements.txt) file as needed. To execute a python script with the image dependencies run the image with the local script directory volume mapped:

```sh
docker run -v .:/app -t -e SOME_ENV_VAR=some-value hmpps-python-deps:latest ./script.py <some-argument>
```
