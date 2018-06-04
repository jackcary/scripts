#!/bin/bash

#Base URLs
DOT_COM_BASE_URL="https://jackcary.com/"
BITBUCKET_IO_BASE_URL="https://jackcary.bitbucket.io/"
GITHUB_IO_BASE_URL="https://jackcary.github.io/"
GITLAB_IO_BASE_URL="https://jackcary.gitlab.io/"
SURGE_SH_BASE_URL="https://jackcary.surge.sh/"

#Repo directories
DOT_COM_REPO=$HOME/jackcary.com
BITBUCKET_IO_REPO=$HOME/jackcary.bitbucket.io
GITHUB_IO_REPO=$HOME/jackcary.github.io
GITLAB_IO_REPO=$HOME/jackcary.gitlab.io
SURGE_SH_REPO=$HOME/jackcary.surge.sh

#Clean up dot com destination
#rm -rf $DOT_COM_REPO/public

#Build dot com site
hugo -b $DOT_COM_BASE_URL -s $DOT_COM_REPO -d $DOT_COM_REPO/public --cleanDestinationDir

#Build bitbucket.io site
cd $BITBUCKET_IO_REPO
hugo -b $BITBUCKET_IO_BASE_URL -s $DOT_COM_REPO -d $BITBUCKET_IO_REPO --cleanDestinationDir

#Find/replace GA tracking id for bitbucket.io
find $BITBUCKET_IO_REPO/. -name '*.html' -exec sed -i '' -e 's/UA-105680531-1/UA-105680531-2/g' {} \;

#Stage files, commit, and push to bitbucket.io
git add .
git commit -m "Automated commit and website deployment"
git push

#Build github.io site
cd $GITHUB_IO_REPO
hugo -b $GITHUB_IO_BASE_URL -s $DOT_COM_REPO -d $GITHUB_IO_REPO --cleanDestinationDir

#Find/replace GA tracking id for github.io
find $GITHUB_IO_REPO/. -name '*.html' -exec sed -i '' -e 's/UA-105680531-1/UA-105680531-3/g' {} \;

#Stage files, commit, and push to github.io
git add .
git commit -m "Automated commit and website deployment"
git push

#Build gitlab.io site
cd $GITLAB_IO_REPO
hugo -b $GITLAB_IO_BASE_URL -s $DOT_COM_REPO -d $GITLAB_IO_REPO --cleanDestinationDir

#Find/replace GA tracking id for gitlab.io
find $GITLAB_IO_REPO/. -name '*.html' -exec sed -i '' -e 's/UA-105680531-1/UA-105680531-4/g' {} \;

#Stage files, commit, and push to gitlab.io
git add .
git commit -m "Automated commit and website deployment"
git push

#Build surge.sh site
cd $SURGE_SH_REPO
hugo -b $SURGE_SH_BASE_URL -s $DOT_COM_REPO -d $SURGE_SH_REPO --cleanDestinationDir

#Find/replace GA tracking id for surge.sh
find $SURGE_SH_REPO/. -name '*.html' -exec sed -i '' -e 's/UA-105680531-1/UA-105680531-5/g' {} \;

#Execute surge command
surge $SURGE_SH_REPO/ $SURGE_SH_BASE_URL
