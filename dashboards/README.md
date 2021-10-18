[<img alt="alt_text" width="1216px" src="https://squaredup-app-assets-bucket-us-east-1.s3.amazonaws.com/deprecated.png" />](https://dashboards.squaredup.com/)

# Sample Dashboards

This folder contains sample dashboards from the community that can be used to get a quickstart on a new dashboarding project.

You'll find a mix of complete dashboards with loads of awesome examples or just simple views to share a single tile.

Note the folder strucutre of `product-description` when browsing.

---

## How to use these samples

Making use of these sample files is simple.

1. Copy the contents of the JSON file from GitHub
2. In SquaredUp, create a new dashboard
3. Open the JSON editor
4. Paste the contents of the copied file from GitHub into SquaredUp
5. Click _Apply Changes_ and then _Publish_

> **NOTE:**  Some of these samples will require you to set up an API or PowerShell provider in order to fetch data. Some may also reference specific SCOM objects, groups, or classes, or specific Azure resource types, and you may need to update tile scopes to make the sample work in your enviornment. Please ensure you read the readme in the dashboard folder before starting.

---

## How to contribute your own samples

Contributions to this repo are vital to make it as diverse and useful as possible. If you have something to share, check out the [Contributions](https://github.com/squaredup/samples/blob/master/CONTRIBUTING.md) guidelines for an overview of the process.

There are a couple of tips specific to sharing a dashboard or tile...

1. Dashboards may contain **sensitive data**. Ensure you replace this with a useful placeholder before submitting. You should check for...
    - Keys or credentials stored in headers/URLs/scripts.
    - The names of servers / networks / resources referenced in scopes, queries and tile names.
    - URLs contained in queries, row links or task buttons.
    - Any other information that specifically identifies your environment or provides access to it.
2. Where you've inserted placeholders per the previous point, make sure you call this out in your readme with guidance on what to update.
3. Where a SCOM dashboard references a group or class from a specific management pack, make sure you call this out in the readme.
4. Dashboards that use WebAPI or PowerShell tiles may contain a JSON block called `_signing`. You should remove this before submitting.
5. Open Access should be disabled by default. Either make this change in SquaredUp before copying your JSON, or update the `"openAccess"` code block in the footer.

> **NOTE:**  If you're really stuck and need to ask a question, head over to [Community Answers](https://community.squaredup.com/) or the [SquaredUp KB](https://support.squaredup.com/).
