#!/bin/bash

for ORG in `cf orgs | sed '1,3d'`; do
    cf target -o $ORG
    for SPACE in `cf spaces | sed '1,3d' `; do
        cf target -s $SPACE
        for APP in `cf apps | sed '1,4d' | cut -f1 -d" "`; do
            cf app $APP | grep "instances:" > Report_${ORG}_${SPACE}_${APP}-CurrentInstancesUsage.txt 2>&1
            cf events $APP | grep "instances:" > Report_${ORG}_${SPACE}_${APP}-InstancesHistoricalEvents.txt 2>&1
            cf events apps-manager | grep "state:" > Report_${ORG}_${SPACE}_${APP}-InstancesStatusEvents.txt 2>&1
            exit;
        done;
    done;
done;
