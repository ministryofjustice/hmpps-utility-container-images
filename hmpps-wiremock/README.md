# HMPPS WireMock

`hmpps-wiremock` is a Docker container designed to deploy a WireMock server with mappings and 
response files.

## Features

- **Pull and deploy WireMock mappings from a list of repositories** specified via environment variables.
    - **Extracts WireMock mappings** from each repository.
    - **Removes duplicate stub IDs** to prevent conflicts.
- **Use built-in WireMocks, stored in `wiremock/`**
- **Starts a WireMock server** on port `8090`.

---

## Usage

### **Environment Variables**
The container uses the following environment variables:

| Variable           | Description                                                        |
|-------------------|--------------------------------------------------------------------|
| `WIREMOCK_REPOS`  | JSON array of repositories to clone (see example below).           |
| `GITHUB_TOKEN`    | Personal Access Token (PAT) used for cloning private repositories. |

### **Example `WIREMOCK_REPOS` Configuration**
You can pass `WIREMOCK_REPOS` as a JSON array of repositories, branches, and paths.

```json
[
  {
    "repoUrl": "https://github.com/ministryofjustice/hmpps-education-and-work-plan-ui",
    "branch": "main",
    "path": "wiremock"
  },
  {
    "repoUrl": "https://github.com/ministryofjustice/hmpps-approved-premises-api",
    "branch": "main",
    "path": "wiremock"
  }
]
```


### Spinning up as an extra container in a helm deployment
To spin this up alongside your service, simply add 

```
   extraContainers:
    - name: wiremock
      image: "ghcr.io/ministryofjustice/hmpps-wiremock:latest"
      imagePullPolicy: IfNotPresent
      env:
        - name: WIREMOCK_REPOS
          value: |-
            [
              {
                "repoUrl": "https://github.com/ministryofjustice/hmpps-education-and-work-plan-ui",
                "branch": "main",
                "path": "wiremock"
              },
              {
                "repoUrl": "https://github.com/ministryofjustice/hmpps-approved-premises-api",
                "branch": "main",
                "path": "wiremock"
              }
            ]
      ports:
        - name: http
          containerPort: 8090
          protocol: TCP
```
to your `values-dev.yml`'s `generic-service` section. Then update any API urls to be `wiremock:8090`. 
Obviously replace the example wiremock repo's with those relevant to your project.


