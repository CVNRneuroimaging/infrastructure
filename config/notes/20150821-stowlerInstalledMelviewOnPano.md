# installed melview on pano

## installed dependencies per README and melview [webpage](http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Melview)
```bash
[01:00:29]-[stowler-local]-at-[pano]-in-[~/src.upstream.gitRepos]
$ sudo apt-get install python-configobj python-enthoughtbase python-matplotlib python-nibabel python-pyface python-pyside python-traits python-traitsui 
Reading package lists... Done
Building dependency tree       
Reading state information... Done
python-configobj is already the newest version.
python-matplotlib is already the newest version.
python-matplotlib set to manually installed.
python-traits is already the newest version.
python-nibabel is already the newest version.
The following extra packages will be installed:
  libphonon4 libpyside1.2 libshiboken1.2 phonon phonon-backend-gstreamer
  phonon-backend-gstreamer-common phonon-backend-gstreamer1.0 python-apptools
  python-pyside.phonon python-pyside.qtcore python-pyside.qtdeclarative
  python-pyside.qtgui python-pyside.qthelp python-pyside.qtnetwork
  python-pyside.qtopengl python-pyside.qtscript python-pyside.qtsql
  python-pyside.qtsvg python-pyside.qttest python-pyside.qtuitools
  python-pyside.qtwebkit python-pyside.qtxml
Suggested packages:
  phonon-backend-vlc phonon4qt5-backend-gstreamer
The following NEW packages will be installed:
  libphonon4 libpyside1.2 libshiboken1.2 phonon phonon-backend-gstreamer
  phonon-backend-gstreamer-common phonon-backend-gstreamer1.0 python-apptools
  python-enthoughtbase python-pyface python-pyside python-pyside.phonon
  python-pyside.qtcore python-pyside.qtdeclarative python-pyside.qtgui
  python-pyside.qthelp python-pyside.qtnetwork python-pyside.qtopengl
  python-pyside.qtscript python-pyside.qtsql python-pyside.qtsvg
  python-pyside.qttest python-pyside.qtuitools python-pyside.qtwebkit
  python-pyside.qtxml python-traitsui
0 upgraded, 26 newly installed, 0 to remove and 2 not upgraded.
Need to get 6,188 kB of archives.
After this operation, 32.5 MB of additional disk space will be used.
Do you want to continue? [Y/n] 
```

## ran install command per melview [webpage](http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Melview)

```bash
[01:07:58]-[stowler-local]-at-[pano]-in-[~/src.upstream.gitRepos/melview] on master
$ sudo python ./setup.py install
running install
running bdist_egg
running egg_info
creating melview.egg-info
writing requirements to melview.egg-info/requires.txt
writing melview.egg-info/PKG-INFO
writing top-level names to melview.egg-info/top_level.txt
writing dependency_links to melview.egg-info/dependency_links.txt
writing entry points to melview.egg-info/entry_points.txt
writing manifest file 'melview.egg-info/SOURCES.txt'
reading manifest file 'melview.egg-info/SOURCES.txt'
writing manifest file 'melview.egg-info/SOURCES.txt'
installing library code to build/bdist.linux-x86_64/egg
running install_lib
running build_py
creating build
creating build/lib.linux-x86_64-2.7
creating build/lib.linux-x86_64-2.7/melview
copying melview/mv2fix.py -> build/lib.linux-x86_64-2.7/melview
copying melview/melodic_traits.py -> build/lib.linux-x86_64-2.7/melview
copying melview/__init__.py -> build/lib.linux-x86_64-2.7/melview
creating build/lib.linux-x86_64-2.7/fsl
copying fsl/melodic.py -> build/lib.linux-x86_64-2.7/fsl
copying fsl/__init__.py -> build/lib.linux-x86_64-2.7/fsl
copying fsl/caches.py -> build/lib.linux-x86_64-2.7/fsl
creating build/bdist.linux-x86_64
creating build/bdist.linux-x86_64/egg
creating build/bdist.linux-x86_64/egg/melview
copying build/lib.linux-x86_64-2.7/melview/mv2fix.py -> build/bdist.linux-x86_64/egg/melview
copying build/lib.linux-x86_64-2.7/melview/melodic_traits.py -> build/bdist.linux-x86_64/egg/melview
copying build/lib.linux-x86_64-2.7/melview/__init__.py -> build/bdist.linux-x86_64/egg/melview
creating build/bdist.linux-x86_64/egg/fsl
copying build/lib.linux-x86_64-2.7/fsl/melodic.py -> build/bdist.linux-x86_64/egg/fsl
copying build/lib.linux-x86_64-2.7/fsl/__init__.py -> build/bdist.linux-x86_64/egg/fsl
copying build/lib.linux-x86_64-2.7/fsl/caches.py -> build/bdist.linux-x86_64/egg/fsl
byte-compiling build/bdist.linux-x86_64/egg/melview/mv2fix.py to mv2fix.pyc
byte-compiling build/bdist.linux-x86_64/egg/melview/melodic_traits.py to melodic_traits.pyc
byte-compiling build/bdist.linux-x86_64/egg/melview/__init__.py to __init__.pyc
byte-compiling build/bdist.linux-x86_64/egg/fsl/melodic.py to melodic.pyc
byte-compiling build/bdist.linux-x86_64/egg/fsl/__init__.py to __init__.pyc
byte-compiling build/bdist.linux-x86_64/egg/fsl/caches.py to caches.pyc
creating build/bdist.linux-x86_64/egg/EGG-INFO
copying melview.egg-info/PKG-INFO -> build/bdist.linux-x86_64/egg/EGG-INFO
copying melview.egg-info/SOURCES.txt -> build/bdist.linux-x86_64/egg/EGG-INFO
copying melview.egg-info/dependency_links.txt -> build/bdist.linux-x86_64/egg/EGG-INFO
copying melview.egg-info/entry_points.txt -> build/bdist.linux-x86_64/egg/EGG-INFO
copying melview.egg-info/requires.txt -> build/bdist.linux-x86_64/egg/EGG-INFO
copying melview.egg-info/top_level.txt -> build/bdist.linux-x86_64/egg/EGG-INFO
zip_safe flag not set; analyzing archive contents...
creating dist
creating 'dist/melview-1.0.1-py2.7.egg' and adding 'build/bdist.linux-x86_64/egg' to it
removing 'build/bdist.linux-x86_64/egg' (and everything under it)
Processing melview-1.0.1-py2.7.egg
Copying melview-1.0.1-py2.7.egg to /usr/local/lib/python2.7/dist-packages
Adding melview 1.0.1 to easy-install.pth file
Installing melview script to /usr/local/bin
Installing mv2fix script to /usr/local/bin

Installed /usr/local/lib/python2.7/dist-packages/melview-1.0.1-py2.7.egg
Processing dependencies for melview==1.0.1
Searching for tornado
Reading https://pypi.python.org/simple/tornado/
Best match: tornado 4.2.1
Downloading https://pypi.python.org/packages/source/t/tornado/tornado-4.2.1.tar.gz#md5=d523204389cfb70121bb69709f551b20
Processing tornado-4.2.1.tar.gz
Writing /tmp/easy_install-Cxb0VG/tornado-4.2.1/setup.cfg
Running tornado-4.2.1/setup.py -q bdist_egg --dist-dir /tmp/easy_install-Cxb0VG/tornado-4.2.1/egg-dist-tmp-_0azll
no previously-included directories found matching 'docs/build'
warning: no files found matching 'tornado/test/README'
tornado/speedups.c:49:1: warning: function declaration isn’t a prototype [-Wstrict-prototypes]
 initspeedups() {
 ^
zip_safe flag not set; analyzing archive contents...
tornado.autoreload: module references __file__
tornado.testing: module references __file__
tornado.test.locale_test: module references __file__
tornado.test.iostream_test: module references __file__
tornado.test.options_test: module references __file__
tornado.test.template_test: module references __file__
tornado.test.httpserver_test: module references __file__
tornado.test.web_test: module references __file__
Adding tornado 4.2.1 to easy-install.pth file

Installed /usr/local/lib/python2.7/dist-packages/tornado-4.2.1-py2.7-linux-x86_64.egg
Searching for certifi
Reading https://pypi.python.org/simple/certifi/
Best match: certifi 2015.04.28
Downloading https://pypi.python.org/packages/source/c/certifi/certifi-2015.04.28.tar.gz#md5=12c7c3a063b2ff97a0f8291d8de41e8c
Processing certifi-2015.04.28.tar.gz
Writing /tmp/easy_install-EOknXH/certifi-2015.04.28/setup.cfg
Running certifi-2015.04.28/setup.py -q bdist_egg --dist-dir /tmp/easy_install-EOknXH/certifi-2015.04.28/egg-dist-tmp-Kj_nd3
zip_safe flag not set; analyzing archive contents...
certifi.core: module references __file__
Adding certifi 2015.04.28 to easy-install.pth file

Installed /usr/local/lib/python2.7/dist-packages/certifi-2015.04.28-py2.7.egg
Searching for backports.ssl-match-hostname
Reading https://pypi.python.org/simple/backports.ssl_match_hostname/
Best match: backports.ssl-match-hostname 3.4.0.2
Downloading https://pypi.python.org/packages/source/b/backports.ssl_match_hostname/backports.ssl_match_hostname-3.4.0.2.tar.gz#md5=788214f20214c64631f0859dc79f23c6
Processing backports.ssl_match_hostname-3.4.0.2.tar.gz
Writing /tmp/easy_install-9Tp3W9/backports.ssl_match_hostname-3.4.0.2/setup.cfg
Running backports.ssl_match_hostname-3.4.0.2/setup.py -q bdist_egg --dist-dir /tmp/easy_install-9Tp3W9/backports.ssl_match_hostname-3.4.0.2/egg-dist-tmp-wxMwxs
zip_safe flag not set; analyzing archive contents...
backports.__init__: module references __path__
Adding backports.ssl-match-hostname 3.4.0.2 to easy-install.pth file

Installed /usr/local/lib/python2.7/dist-packages/backports.ssl_match_hostname-3.4.0.2-py2.7.egg
Searching for scipy==0.13.3
Best match: scipy 0.13.3
Adding scipy 0.13.3 to easy-install.pth file

Using /usr/lib/python2.7/dist-packages
Searching for numpy==1.8.2
Best match: numpy 1.8.2
numpy 1.8.2 is already the active version in easy-install.pth

Using /usr/lib/python2.7/dist-packages
Searching for nibabel==1.3.0
Best match: nibabel 1.3.0
Adding nibabel 1.3.0 to easy-install.pth file

Using /usr/lib/pymodules/python2.7
Searching for matplotlib==1.3.1
Best match: matplotlib 1.3.1
matplotlib 1.3.1 is already the active version in easy-install.pth

Using /usr/lib/pymodules/python2.7
Searching for setuptools==3.3
Best match: setuptools 3.3
setuptools 3.3 is already the active version in easy-install.pth
Installing easy_install script to /usr/local/bin
Installing easy_install-2.7 script to /usr/local/bin

Using /usr/lib/python2.7/dist-packages
Searching for nose==1.3.1
Best match: nose 1.3.1
nose 1.3.1 is already the active version in easy-install.pth
Installing nosetests script to /usr/local/bin
Installing nosetests-2.7 script to /usr/local/bin

Using /usr/lib/python2.7/dist-packages
Searching for pyparsing==2.0.1
Best match: pyparsing 2.0.1
pyparsing 2.0.1 is already the active version in easy-install.pth

Using /usr/lib/python2.7/dist-packages
Searching for python-dateutil==1.5
Best match: python-dateutil 1.5
python-dateutil 1.5 is already the active version in easy-install.pth

Using /usr/lib/python2.7/dist-packages
Finished processing dependencies for melview==1.0.1
```

## confirmed location of installed melview executables:

...they're not symlinks:


```bash
[01:11:43]-[stowler-local]-at-[pano]-in-[~/src.upstream.gitRepos/melview] on master
$ which melview | xargs ls -l
-rwxr-xr-x 1 root root 301 Aug 21 13:08 /usr/local/bin/melview

[01:12:00]-[stowler-local]-at-[pano]-in-[~/src.upstream.gitRepos/melview] on master
$ which mv2fix | xargs ls -l
-rwxr-xr-x 1 root root 299 Aug 21 13:08 /usr/local/bin/mv2fix
```

