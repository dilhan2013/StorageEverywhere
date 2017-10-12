rd %cd%\Temp /s /q
mkdir %cd%\Temp
nuget pack StorageEverywhere.nuspec -outputDirectory %cd%\Temp
copy %cd%\Temp\*.* %ynsnuget%\StorageEverywhere
copy %cd%\Temp\*.* %cd%
rd %cd%\Temp /s /q