<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Forks][forks-shield]][forks-url]
[![Issues][issues-shield]][issues-url]



<!-- PROJECT LOGO -->
<br />
<h3 align="center">Mod Organizer 2 (MO2) Separator Generator</h3>

  <p align="center">
    A Powershell script to generate separators for Mod Organizer 2
    <br />
    <br />
    <a href="https://www.nexusmods.com/fallout4/mods/79363">View Example Result</a>
    ·
    <a href="https://github.com/Furglitch/MO2-Separator-Generator/issues/new?labels=bug">Report Bug</a>
    ·
    <a href="https://github.com/Furglitch/MO2-Separator-Generator/issues/new?labels=enhancement">Request Feature</a>
  </p>

<br />

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
    <li><a href="#prerequisites">Prerequisites</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#license">License</a></li>
</details>


## Prerequisites

It is highly recommended that you use this for a fresh install of MO2, as your list order (not plugins) will be lost.
<br />
If you insist on using an existing MO2 profile, remove any existing folders within `/mods` that end in `_separator`

<!-- USAGE EXAMPLES -->
## Usage

1. Clone the repo
   ```sh
   git clone https://github.com/Furglitch/MO2-Separator-Generator.git
   ```
2. Edit `config.ini` and `list.txt` to your liking
3. Run `generate.ps1`
4. Copy the `mods` and `profiles` folder into your Mod Organizer 2 installation (If you don't know where your MO2 installation is, run MO2 and click the folder icon, then 'Open Instance folder')

<!-- ROADMAP -->
## Roadmap

- [ ] Allow more color code types within `config.ini`
  - [ ] RGB
  - [ ] HSL

<!-- LICENSE -->
## License

Distributed under the Unlicense License. See `LICENSE` for more information.



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[forks-shield]: https://img.shields.io/github/forks/Furglitch/MO2-Separator-Generator.svg?style=for-the-badge
[forks-url]: https://github.com/Furglitch/MO2-Separator-Generator/network/members
[issues-shield]: https://img.shields.io/github/issues/Furglitch/MO2-Separator-Generator.svg?style=for-the-badge
[issues-url]: https://github.com/Furglitch/MO2-Separator-Generator/issues
