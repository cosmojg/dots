#!/usr/bin/env python3
"""Export documents from ArangoDB collections as JSON and CSV."""
from typing import Annotated

import polars as pl
import typer
from pyArango.connection import Connection as Conn
from pyArango.query import SimpleQuery
from rich import print
from rich.progress import track


def main(
    server: Annotated[
        str,
        typer.Option(help="ArangoDB server URL and port number"),
    ] = "http://127.0.0.1:8529",
    username: Annotated[str, typer.Option(help="ArangoDB username")] = "user",
    password: Annotated[str, typer.Option(help="ArangoDB password")] = "pass",
    database: Annotated[
        str,
        typer.Option(help="name of database"),
    ] = "unnamed_database",
    collection: Annotated[
        str,
        typer.Option(help="name of collection"),
    ] = "unnamed_collection",
    data: Annotated[
        list[str],
        typer.Option(help="name(s) of data object(s)"),
    ] = ["data", "data_truth"],
) -> int:
    """Export documents from ArangoDB collections as JSON and CSV."""
    # Get the ArangoDB collection
    coll = get_collection(server, username, password, database, collection)

    # Export data objects from all documents in collection
    for doc in track(coll):
        for object_name in data:
            df_name = "_".join((object_name, doc["name"], collection))
            object_df = pl.DataFrame(doc[object_name])
            object_df.write_json(f"{df_name}.json")
            object_df.write_csv(f"{df_name}.csv")

    return 0


def get_collection(
    server: str = "http://127.0.0.1:8529",
    username: str = "user",
    password: str = "pass",
    database: str = "unnamed_database",
    collection: str = "unnamed_collection",
) -> SimpleQuery:
    """Get an ArangoDB collection returning documents as raw dictionaries.

    Arguments:
        server: ArangoDB server URL and port number (default 'http://127.0.0.1:8529')
        username: ArangoDB username (default 'user')
        password: ArangoDB password (default 'pass')
        database: name of database (default 'unnamed_database')
        collection: name of collection (default 'unnamed_collection')
    """
    # Connect to the Arango database
    db = Conn(arangoURL=server, username=username, password=password)[database]

    # Store the Arango collection as a SimpleQuery
    coll = db[collection].fetchAll(rawResults=True)

    # Print information about collected documents
    print(f"Database: {database}")
    print(f"Collection: {collection}")
    print(f"Documents: {[doc['name'] for doc in coll]}")

    return coll


if __name__ == "__main__":
    typer.run(main)
