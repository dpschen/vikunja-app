# Vikunja Cross-Platform App
![GitHub release (latest by SemVer including pre-releases)](https://img.shields.io/github/downloads-pre/go-vikunja/app/latest/total)
![Matrix](https://img.shields.io/matrix/vikunja%3Amatrix.org)

Download from [Releases](https://github.com/go-vikunja/app/releases/latest)

## Fork

This repository forks [go-vikunja/app](https://github.com/go-vikunja/app) and
mainly differs in how CI and releases are handled. The legacy Drone pipeline was
removed and replaced with GitHub Actions which builds and publishes new
releases. All other code stays mostly in sync with upstream.

### Git remotes

Your writable fork should be configured as `origin` while the upstream project
remains read-only under the `upstream` remote:

```bash
git clone git@github.com:<your-username>/vikunja-app.git
cd vikunja-app
git remote add upstream https://github.com/go-vikunja/app.git
```

### Fastlane environment

Fastlane is used for Android and iOS builds. When running lanes locally or in
CI the following environment variables need to be present:

`GPG_PASS` – decrypts `keystore.jks`, `key.properties` and `fastlane-secret.json`

`FASTLANE_SKIP_UPDATE_CHECK` and `FASTLANE_HIDE_CHANGELOG` – suppress update
prompts

`FASTLANE_PASSWORD`, `FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD` and
`FASTLANE_SESSION` – credentials for iOS publishing

These are defined as secrets for GitHub Actions but may be exported locally when
invoking `fastlane`.

## Disclaimer

This app is in alpha pre-release. You must absolutely expect things to not work, and sometimes even break something in the backend. Using this app on important production backends is possible but discouraged. However, as we rely on your feedback about missing features and bugs, we do encourage you to try it out and give us feedback here on GitHub. We are not responsible for lost data and similar destruction.

If you have anything to contribute, please open a PR. It is encouraged to let us know before you start developing, so we can discuss possible overlap with features other people might already be working on. This avoids unnecessary waste of time for either party.

It will be a while until this app is released to the Google Play Store. Until then, please download from the [Releases](https://github.com/go-vikunja/app/releases/latest) page. If you want to try this app on an iPhone, I cannot provide support, as I do not have an iPhone to develop on. However, contributors have confirmed that it works™. If you do decide to try it out, please share with the community any bugs you experience.
