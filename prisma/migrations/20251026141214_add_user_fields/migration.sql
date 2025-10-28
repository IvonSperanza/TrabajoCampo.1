/*
  Warnings:

  - You are about to drop the column `password` on the `User` table. All the data in the column will be lost.
  - Added the required column `passwordHash` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `User` table without a default value. This is not possible if the table is not empty.

*/
BEGIN TRY

BEGIN TRAN;

-- AlterTable
ALTER TABLE [dbo].[User] DROP COLUMN [password];
ALTER TABLE [dbo].[User] ADD [firstName] NVARCHAR(1000),
[isOwner] BIT NOT NULL CONSTRAINT [User_isOwner_df] DEFAULT 0,
[lastName] NVARCHAR(1000),
[passwordHash] NVARCHAR(1000) NOT NULL,
[updatedAt] DATETIME2 NOT NULL;

-- CreateTable
CREATE TABLE [dbo].[Owner] (
    [id] INT NOT NULL IDENTITY(1,1),
    [userId] INT NOT NULL,
    [cuit] NVARCHAR(1000) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [Owner_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [Owner_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [Owner_userId_key] UNIQUE NONCLUSTERED ([userId])
);

-- AddForeignKey
ALTER TABLE [dbo].[Owner] ADD CONSTRAINT [Owner_userId_fkey] FOREIGN KEY ([userId]) REFERENCES [dbo].[User]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
