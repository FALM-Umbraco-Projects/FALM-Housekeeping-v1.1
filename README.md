FALM-Housekeeping
=================
This package adds a tree node to the developer section with the following tools:
- Umbraco logs manager: with this tool you can view and delete Umbraco log events.
N.B.: in order to improve the performance of the log viewer, you can add SQL indexes to the coloumns DateStamp, UserId and LogHeader of umbracoLog table.
- Media folder cleanup: with this tool you can delete those file system folders under '/media' which have no entry in the DB (orphans)
N.B.: in the current release this feature works only with "UploadAllowDirectories" set to "true".
- Delete users: with this tool you can completely remove Umbraco users.
- Version manager: with this tool you can view and cleanup the version history that Umbraco mantains for each content node.

Versions History
=================
- v1.1.0.0 - Version compatible with Umbraco v4.0 
- Logs manager: 
     - Added filtering capabilities on NodeId
     - Improved date filter: now you can select a range between two dates
- Media folder cleanup:
     - Various fixes in the search algorithm.
- Delete users:
     - Changed sort order and display of disabled users to match standard Umbraco behaviour
- Version manager:
     - Added filtering capabilities on NodeId
     - Improved date filter: now you can select a range between two dates
     - Added paging
     - Rewritten code with direct access to DB to make performance way faster
- v1.0.0.0 - Initial release
