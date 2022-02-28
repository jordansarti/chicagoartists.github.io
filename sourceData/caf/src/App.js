import React, { useState } from 'react'
import './App.css'
import Main from './components/main'
import Sidebar from './components/sidebar'

import { createDbWorker } from "sql.js-httpvfs"

import workerUrl from "file-loader!sql.js-httpvfs/dist/sqlite.worker.js"
import wasmUrl from "file-loader!sql.js-httpvfs/dist/sql-wasm.wasm"

function App() {
  const [termFilter, setTermFilter] = useState('Photography')
  const [cultFilter, setCultFilter] = useState('Hong Kong')
  return (
    <div className="App">
      <Sidebar termFilter={termFilter} setTermFilter={setTermFilter} cultFilter={cultFilter} setCultFilter={setCultFilter} />
      <Main termFilter={termFilter} setTermFilter={setTermFilter} cultFilter={cultFilter} setCultFilter={setCultFilter} />
    </div>
  );
}

export default App;



// sadly there's no good way to package workers and wasm directly so you need a way to get these two URLs from your bundler.
// This is the webpack5 way to create a asset bundle of the worker and wasm:
// const workerUrl = new URL(
//   "sql.js-httpvfs/dist/sqlite.worker.js",
//   import.meta.url,
// );
// const wasmUrl = new URL(
//   "sql.js-httpvfs/dist/sql-wasm.wasm",
//   import.meta.url,
// );
// the legacy webpack4 way is something like `
// the legacy webpack4 way is something like `

// the config is either the url to the create_db script, or a inline configuration:
const config = {
  from: "inline",
  config: {
    serverMode: "full", // file is just a plain old full sqlite database
    requestChunkSize: 4096, // the page size of the  sqlite database (by default 4096)
    url: "./data/caf.db" // url to the database (relative or full)
  }
};
// or:
// const config = {
//   from: "jsonconfig",
//   configUrl: "/foo/bar/config.json"
// }
(async () => {
const worker = await createDbWorker(
  [config],
  workerUrl.toString(), wasmUrl.toString()
)})
// you can also pass multiple config objects which can then be used as separate database schemas with `ATTACH virtualFilename as schemaname`, where virtualFilename is also set in the config object.


// worker.db is a now SQL.js instance except that all functions return Promises.
(async () => {
const result = await worker.db.exec("select * from `Artist Information` where id = ?", [123])
})