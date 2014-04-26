
echo Getting packages
pub get

echo Generating documentation
docgen --compile --package-root=packages --no-include-sdk --introduction=README.md --start-page=lithium_ion lib

echo Removing package links
rm dartdoc-viewer/client/out/web/packages
rm dartdoc-viewer/client/out/web/docs/packages
rm dartdoc-viewer/client/out/web/docs/lithium_ion/packages

rm dartdoc-viewer/client/out/web/static/packages
rm dartdoc-viewer/client/out/web/static/js/packages
rm dartdoc-viewer/client/out/web/static/css/packages

echo Staging documentation
mv dartdoc-viewer/client/out/packages dartdoc-viewer/client/out/web/packages
mv dartdoc-viewer/client/out/web .docs_staging

echo Moving to GitHub pages
git fetch origin
git branch -v -a
rm -rf *
git checkout --track -b gh-pages origin/gh-pages

echo Unstaging files
mv .docs_staging docs

echo Committing GitHub pages
git commit -A
git commit -m "Auto-commit from Drone"
git push origin gh-pages
