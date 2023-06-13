#!/usr/bin/env python3
"""Export documents from ArangoDB collections as JSON and CSV."""
from __future__ import annotations

import argparse
import json
from typing import TYPE_CHECKING

import polars as pl
from pyArango.connection import Connection

if TYPE_CHECKING:
    import pyArango.query.SimpleQuery


def main(argv: list[str] | None = None) -> int:
    """Export documents from ArangoDB collections as JSON and CSV."""
    parser = argparse.ArgumentParser(
        description="Export documents from ArangoDB collections as JSON and CSV.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument(
        "--server",
        type=str,
        default="http://127.0.0.1:8529",
        help="ArangoDB server URL and port number",
    )
    parser.add_argument(
        "--username",
        type=str,
        help="ArangoDB username",
    )
    parser.add_argument(
        "--password",
        type=str,
        help="ArangoDB password",
    )
    parser.add_argument(
        "--database",
        type=str,
        default="unnamed_database",
        help="name of database",
    )
    parser.add_argument(
        "--collection",
        type=str,
        default="unnamed_collection",
        help="name of collection",
    )
    parser.add_argument(
        "--documents",
        nargs="*",
        default="all",
        help="name(s) of data document(s) (UNIMPLEMENTED!)",
    )
    parser.add_argument(
        "--objects",
        nargs="*",
        default=["data", "data_truth"],
        help="name(s) of data object(s)",
    )

    args = parser.parse_args(argv)

    # Get the ArangoDB collection
    coll = get_collection(
        args.server,
        args.username,
        args.password,
        args.database,
        args.collection,
    )

    # Export objects from all documents in collection
    for doc in coll:
        for object_name in args.objects:
            df_name = "_".join((object_name, doc["name"], args.collection))
            object_df = pl.read_json(json.dumps(doc[object_name]))
            object_df.write_json(f"{df_name}.json")
            object_df.write_csv(f"{df_name}.csv")

    return 0


def get_collection(
    username: str,
    password: str,
    server: str = "http://127.0.0.1:8529",
    database: str = "unnamed_database",
    collection: str = "unnamed_collection",
) -> pyArango.query.SimpleQuery:
    """Get an ArangoDB collection returning documents as raw dictionaries.

    Arguments:
        username: ArangoDB username
        password: ArangoDB password
        server: ArangoDB server URL and port number (default 'http://127.0.0.1:8529')
        database: name of database (default 'unnamed_database')
        collection: name of collection (default 'unnamed_collection')
    """
    # Connect to the Arango database
    db = Connection(server, username, password)[database]

    # Store the Arango collection as a SimpleQuery
    coll = db[collection].fetchAll(rawResults=True)

    # Print information about collected documents
    print(f"Database: {database}")
    print(f"Collection: {collection}")
    print(f"Documents: {[doc['name'] for doc in coll]}")

    return coll


if __name__ == "__main__":
    raise SystemExit(main())