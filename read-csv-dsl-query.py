# -*- coding: utf-8 -*-
"""
Created on Tue Nov 30 08:58:29 2021

This script will load the CSV into the query, loop through 400 items and then export a csv. Currently a second csv is commented out.

@author: sullivm1
"""

import dimcli
from dimcli.utils import *

import sys, time, json
import pandas as pd
from tqdm.notebook import tqdm as progressbar

import plotly.express as px

dimcli.login()

dsl = dimcli.Dsl()

pd.options.display.max_columns = None
#This works csv below works. The spreadsheet is exported from Dimensions
doi_source = pd.read_csv("C:/Users/sullivm1/.dimensions/sample-pubs.csv")

#Below is a spreadsheet made by Max
#doi_source = pd.read_csv("C:/Users/sullivm1/.dimensions/doi-sample.csv")
# pull out the doi IDs as a list
doi_source.head(15)

#Turn dimensions csv into list
doi_id = list(doi_source['DOI'])

#Turn Maxs csv into list
#doi_id = list(doi_source['doi'])


print(doi_id)

#
# the main query
#
q = """search publications
        where doi in {}
      return publications[basics+doi+category_for]"""


#
# let's loop through all grants IDs in chunks and query Dimensions
#
print("===\nExtracting pub data ...")

results = []

for chunk in progressbar(list(chunks_of(list(doi_id), 400))):
   data = dsl.query_iterative(q.format(json.dumps(chunk)), verbose=False)
   results += data.publications
   time.sleep(1)

#
# put the patents data into a dataframe, remove duplicates and save
#
publications = pd.DataFrame().from_dict(results)
print("Pubs found: ", len(publications))
publications.drop_duplicates(subset='id', inplace=True)
print("Unique publications found: ", len(publications))

#Code below seems to have bad effect on DOI#
if 'doi' in publications:
    # turning lists into strings to ensure compatibility with CSV loaded data
    # see also: https://stackoverflow.com/questions/23111990/pandas-dataframe-stored-list-as-string-how-to-convert-back-to-list
    publications['doi'] = publications['doi'].apply(lambda x: ','.join(map(str, x)))
else:
    publications['doi'] = ""


publications.head(5)


publications.to_csv(".dimensions\sample-pubs-output-test.csv", index=False)

#
# count patents per grant and enrich the original dataset
#
#def patents_for_grantid(doi):
#  global publications
#  return publications[patents['associated_grant_ids'].str.contains(grantid)]

#print("===\nCounting patents per grant...")

#l = []
#for x in progressbar(doi):
#  l.append(len(patents_for_grantid(x)))

#publications['Associated Patents'] = l

#print("===\nDone")

dimcli.logout()
