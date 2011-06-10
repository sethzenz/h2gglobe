#!/bin/bash
#1 Working Directory
#2 Mass
cd $1
ODIR=$1/$2GeV
if [ ! -d $ODIR ]; then
	mkdir $ODIR
fi
eval `scramv1 runtime -sh`
combine cms-hgg-datacard_parBKG.txt -M ProfileLikelihood -D data_mass -m $2 -s -1 --rMin=0 --rMax=30 -n TEST --tries 3 --maxTries 100 -v 1 | tee mH$2.$$.log
SEED=`cat mH$2.$$.log | grep '>>> Used OpenSSL to get a really random seed' | awk '{print$10}'`
mv mH$2.$$.log $ODIR/higgsCombineTEST.OBSProfileLikelihood.mH$2.$SEED.log
mv higgsCombineTEST.ProfileLikelihood.mH$2.$SEED.root $ODIR/higgsCombineTEST.OBSProfileLikelihood.mH$2.$SEED.root
