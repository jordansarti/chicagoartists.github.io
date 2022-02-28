import { createDbWorker } from "sql.js-httpvfs";

const workerUrl = new URL(
  "sql.js-httpvfs/dist/sqlite.worker.js",
  import.meta.url
);
const wasmUrl = new URL("sql.js-httpvfs/dist/sql-wasm.wasm", import.meta.url);

async function load() {
  const worker = await createDbWorker(
    [
      {
        from: "inline",
        config: {
          serverMode: "full",
          url: "/mysqlite3.db",
          requestChunkSize: 4096,
        },
      },
    ],
    workerUrl.toString(),
    wasmUrl.toString()
  );

  const testQuery = `select * from artist_information where 'Artist Accession Number' = ` + 6519
  console.log(testQuery)
  const result = await worker.db.query(testQuery);
  console.log(result)

  document.body.textContent = JSON.stringify(result);
}

load();
