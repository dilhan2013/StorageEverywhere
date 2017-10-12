## StorageEverywhere

This plugin is ported from [PCLStorage](https://github.com/dsplaisted/PCLStorage/blob/master/README.md), because I need this plugin to work with .NET Standard.

**Supported Platforms**


|Platform|
|---------|
|.NET Standard 1.0|
|Android|
|iOS|
|WPF .NET 4.5|
|UWP|

**Installation**

Get from [Nuget](https://www.nuget.org/packages/StorageEverywhere)

If you reference from PCL/Net Standard, you also need to reference from each platform-platform specific app.

**The following helper will help you to get through this:**
```csharp
using System.Collections.Generic;
using System.Threading.Tasks;

using StorageEverywhere;

namespace StorageEverywhere.Helpers
{
    public static class StorageEverywhereHelper
    {
        public async static Task<bool> IsFileExistAsync(this string fileName, IFolder rootFolder = null)
        {
            // get hold of the file system
            IFolder folder = rootFolder ?? FileSystem.Current.LocalStorage;
            ExistenceCheckResult folderexist = await folder.CheckExistsAsync(fileName);
            // already run at least once, don't overwrite what's there  
            if (folderexist == ExistenceCheckResult.FileExists)
            {
                return true;
            }
            return false;
        }

        public async static Task<bool> IsFolderExistAsync(this string folderName, IFolder rootFolder = null)
        {
            // get hold of the file system  
            IFolder folder = rootFolder ?? FileSystem.Current.LocalStorage;
            ExistenceCheckResult folderexist = await folder.CheckExistsAsync(folderName);
            // already run at least once, don't overwrite what's there  
            if (folderexist == ExistenceCheckResult.FolderExists)
            {
                return true;
            }
            return false;
        }

        public async static Task<IFolder> CreateFolder(this string folderName, IFolder rootFolder = null)
        {
            IFolder folder = rootFolder ?? FileSystem.Current.LocalStorage;
            folder = await folder.CreateFolderAsync(folderName, CreationCollisionOption.ReplaceExisting);
            return folder;
        }

        public async static Task<IFolder> GetFolderAsync(this string folderName, IFolder rootFolder = null)
        {
            IFolder folder = rootFolder ?? FileSystem.Current.LocalStorage;
            folder = await folder.GetFolderAsync(folderName);
            return folder;
        }

        public async static Task<IFile> CreateFile(this string filename, IFolder rootFolder = null)
        {
            IFolder folder = rootFolder ?? FileSystem.Current.LocalStorage;
            IFile file = await folder.CreateFileAsync(filename, CreationCollisionOption.ReplaceExisting);
            return file;
        }

        public async static Task<IList<IFile>> GetFilesAsync(this string filename, IFolder rootFolder = null)
        {
            IFolder folder = rootFolder ?? FileSystem.Current.LocalStorage;
            return await folder.GetFilesAsync();
        }

        public async static Task<IFile> GetFileAsync(this string filename, IFolder rootFolder = null)
        {
            IFolder folder = rootFolder ?? FileSystem.Current.LocalStorage;
            return await folder.GetFileAsync(filename);
        }

        public async static Task<bool> WriteTextAllAsync(this string filename, string content = "", IFolder rootFolder = null)
        {
            IFile file = await filename.CreateFile(rootFolder);
            await file.WriteAllTextAsync(content);
            return true;
        }

        public async static Task<string> ReadAllTextAsync(this string fileName, IFolder rootFolder = null)
        {
            string content = "";
            IFolder folder = rootFolder ?? FileSystem.Current.LocalStorage;
            bool exist = await fileName.IsFileExistAsync(folder);
            if (exist == true)
            {
                IFile file = await folder.GetFileAsync(fileName);
                content = await file.ReadAllTextAsync();
            }
            return content;
        }
        public async static Task<bool> DeleteFile(this string fileName, IFolder rootFolder = null)
        {
            IFolder folder = rootFolder ?? FileSystem.Current.LocalStorage;
            bool exist = await fileName.IsFileExistAsync(folder);
            if (exist == true)
            {
                IFile file = await folder.GetFileAsync(fileName);
                await file.DeleteAsync();
                return true;
            }
            return false;
        }
    }
}
```