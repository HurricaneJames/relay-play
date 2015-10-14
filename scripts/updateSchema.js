#!/usr/bin/env babel-node --optional es7.asyncFunctions

// taken directly from (relay-starter-kit)[http://github.com/relayjs/relay-starter-kit]

import fs from 'fs';
import path from 'path';
import fetch from 'node-fetch';
import { introspectionQuery, printSchema } from 'graphql/utilities';

// Save JSON of full schema introspection for Babel Relay Plugin to use
// async () => {
  console.log('Introspect: ');
  console.log(JSON.stringify(introspectionQuery));
  // var result = await (graphql(Schema, introspectionQuery));
  fetch('http://localhost:3000/graphql', {
    method: 'post',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ query: introspectionQuery, variables: {} }),
  }).then(function (response) {
    return response.json();
  }).then((result) => {
    console.log('Success: ', result);
    if (result.errors) {
      console.error(
        'ERROR introspecting schema: ',
        JSON.stringify(result.errors, null, 2)
      );
    } else {
      console.log('Writing: ', path.join(__dirname, '../schema.json'));
      fs.writeFileSync(
        path.join(__dirname, '../schema.json'),
        JSON.stringify(result, null, 2)
      );
    }
  }).catch((something) => {
    console.log('Error: ', something);
  });

// Save user readable type system shorthand of schema
// fs.writeFileSync(
//   path.join(__dirname, '../schema.graphql'),
//   printSchema(Schema)
// );