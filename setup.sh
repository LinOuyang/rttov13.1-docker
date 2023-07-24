DIR=/usr/local/envs
mkdir $DIR


cd /tmp
tar xzvf zlib-1.2.7.tar.gz
cd zlib-1.2.7
./configure --prefix=$DIR/zlib
make
make install
cd ..                     
export LD_LIBRARY_PATH=$DIR/zlib/lib:$LD_LIBRARY_PATH


tar xzvf hdf5-hdf5-1_8_23.tar.gz
cd hdf5-hdf5-1_8_23
./configure --with-zlib=$DIR/zlib --prefix=$DIR/hdf5 FC=gfortran CC=gcc --enable-fortran --enable-cxx
make
make install
cd ..
export LD_LIBRARY_PATH=$DIR/hdf5/lib:$LD_LIBRARY_PATH
for f in $DIR/hdf5/bin/* ; do ln -s $f /usr/local/bin ; done



export LDFLAGS=-L$DIR/hdf5/lib
export CPPFLAGS=-I$DIR/hdf5/include
tar xzvf netcdf-c-4.6.3.tar.gz
cd netcdf-c-4.6.3
./configure --prefix=$DIR/netcdf --enable-netcdf-4
make
make install
cd ..


export LDFLAGS=-L$DIR/netcdf/lib
export CPPFLAGS=-I$DIR/netcdf/include
tar xzvf netcdf-fortran-4.5.2.tar.gz
cd netcdf-fortran-4.5.2
./configure --prefix=$DIR/netcdf FC=gfortran
make
make install
cd ..

pip3 install numpy -i https://pypi.tuna.tsinghua.edu.cn/simple

mkdir $DIR/../rttov13
cd /tmp
for file in `ls ./rttov13.1_part*.tar.gz` ; do tar -zxvf $file -C $DIR/../rttov13; done
cd $DIR/../rttov13/build
sed -i "40s/path-to-hdf-install/\/usr\/local\/envs\/hdf5/#" Makefile.local
sed -i "45s/\#\ //#" Makefile.local
sed -i "53s/\#\ //#" Makefile.local
sed -i "71s/path-to-netcdf-install/\/usr\/local\/envs\/netcdf/#" Makefile.local
sed -i "76s/\#\ //#" Makefile.local
sed -i "87s/\#\ //#" Makefile.local

cd $DIR/../rttov13/src
../build/Makefile.PL RTTOV_HDF=1 RTTOV_F2PY=1
make ARCH=gfortran

echo DIR=/usr/local/envs >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=$DIR/zlib/lib:$DIR/hdf5/lib:$DIR/netcdf/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export PATH=$DIR/zlib/bin:$DIR/hdf5/bin:$DIR/netcdf/bin:$PATH' >> ~/.bashrc
