export LIBGDIPLUS_VERSION=6.0.5

brew install autoconf automake libtool pkg-config
brew install libtiff giflib libjpeg glib cairo freetype fontconfig libpng
brew install pkg-config cairo pango libpng jpeg giflib librsvg libjpeg-turbo
cd runtime.osx.10.10-arm64.CoreCompat.System.Drawing
git clone https://github.com/mono/libgdiplus --depth 1 --single-branch --branch ${LIBGDIPLUS_VERSION}

# libffi is keg-only
export LDFLAGS="-L/usr/local/opt/libffi/lib -L/opt/homebrew/opt/jpeg/lib"
export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig:/opt/homebrew/opt/jpeg/lib/pkgconfig"

./build.sh
mkdir ${{ github.workspace }}/bin/
dotnet build -c Release /p:Version=${LIBGDIPLUS_VERSION}.${GITHUB_RUN_NUMBER}
dotnet pack -c Release /p:Version=${LIBGDIPLUS_VERSION}.${GITHUB_RUN_NUMBER} -o ${{ github.workspace }}/bin/

