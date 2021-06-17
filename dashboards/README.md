# Sample Dashboards

This folder contains sample dashboards from the community that can be used to get a quickstart on a new dashboarding project.

You'll find a mix of complete dashboards with loads of awesome examples or just simple views to share a single tile.

Note the folder strucutre of `product-type-description` when browsing.

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

There are a couple of tips specific to sharing a dashboard or tile too...

1. Dashboards may contain sensitive data. Ensure you remove/replace this before submitting.
2. Where a dashboard references a specific object or list of objects in your environment, make sure you call this out in the readme with guidance on what to update.
3. Where a dashboard references a group or class from a specific SCOM management pack, make sure you call this out in the readme.
3. Dashboards that use WebAPI or PowerShell tiles may contain a JSON block called `_signing`. You should remove this before submitting.

> **NOTE:**  If you're really stuck and need to ask a question, head over to [Community Answers](https://community.squaredup.com/) or the [SquaredUp KB](https://support.squaredup.com/).
