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