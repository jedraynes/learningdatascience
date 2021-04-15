# Data Science Capstone

The Data Science Capstone course is the final course in the [Johns Hopkins University Data Science Specialization offered by Coursera](https://www.coursera.org/specializations/jhu-data-science). The course page can be found [here](https://www.coursera.org/learn/data-science-project). The purpose of the course is to put all of the skills together and produce a final project: a word prediction application using R Shiny and NLP techniques. The previous courses haven't taught NLP methods, so this course proved challenging and engaging.

**Capstone Project**: Predictionary

In the final project, I used techniques from the Stupid Back Off algorithm to score and predict the next word given a user's string input. My final web application can take a messy string input (i.e., containing special characters, odd spacing, etc.), clean the string, and return 1 to 10 predictions and their respective score. The score is based on which n-gram family it is derived from (i.e., trigram, bigram, unigram) and adjusted for "backing-off" to lower-level n-grams if not found in higher-level n-grams.

To see my project in action, check out the ShinyApps.io link here: [Predictionary](https://jedraynes.shinyapps.io/Predictionary/).

For the presentation slides published along with my app, check out the RPubs slide deck here: [Predictionary Presentation](https://rpubs.com/jedraynes/752591).

For the files used in the project, refer to the Capstone Project folder in this repository.

---
[![image](https://img.shields.io/badge/Personal%20Site-%20-informational?style=flat-square&logo=appveyor)](https://www.jedraynes.com/)
[![image](https://img.shields.io/badge/LinkedIn-%20-informational?style=flat-square&logo=appveyor)](https://www.linkedin.com/in/jedraynes/)

jedraynes