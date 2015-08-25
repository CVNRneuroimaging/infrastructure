# installed melview on rama

## installed dependencies per README and melview [webpage](http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Melview)
```bash
[14:46:29]-[stowler-local]-at-[rama]-in-[/data/panolocal]
$ sudo apt-get install python-configobj python-enthoughtbase python-matplotlib python-nibabel python-pyface python-pyside python-traits python-traitsui

[sudo] password for stowler-local:
Reading package lists... Done
Building dependency tree
Reading state information... Done
python-configobj is already the newest version.
python-configobj set to manually installed.
python-matplotlib is already the newest version.
python-matplotlib set to manually installed.
python-pyface is already the newest version.
python-pyface set to manually installed.
python-traits is already the newest version.
python-traits set to manually installed.
python-traitsui is already the newest version.
python-traitsui set to manually installed.
The following extra packages will be installed:
  libphonon4 libpyside1.2 libshiboken1.2 phonon phonon-backend-gstreamer
  phonon-backend-gstreamer-common phonon-backend-gstreamer1.0
  python-pyside.phonon python-pyside.qtcore python-pyside.qtdeclarative
  python-pyside.qtgui python-pyside.qthelp python-pyside.qtnetwork
  python-pyside.qtopengl python-pyside.qtscript python-pyside.qtsql
  python-pyside.qtsvg python-pyside.qttest python-pyside.qtuitools
  python-pyside.qtwebkit python-pyside.qtxml
Suggested packages:
  phonon-backend-vlc gstreamer1.0-plugins-ugly phonon4qt5-backend-gstreamer
  python-nibabel-doc
The following NEW packages will be installed:
  libphonon4 libpyside1.2 libshiboken1.2 phonon phonon-backend-gstreamer
  phonon-backend-gstreamer-common phonon-backend-gstreamer1.0
  python-enthoughtbase python-pyside python-pyside.phonon python-pyside.qtcore
  python-pyside.qtdeclarative python-pyside.qtgui python-pyside.qthelp
  python-pyside.qtnetwork python-pyside.qtopengl python-pyside.qtscript
  python-pyside.qtsql python-pyside.qtsvg python-pyside.qttest
  python-pyside.qtuitools python-pyside.qtwebkit python-pyside.qtxml
The following packages will be upgraded:
  python-nibabel
1 upgraded, 23 newly installed, 0 to remove and 3 not upgraded.
Need to get 6,309 kB of archives.
After this operation, 24.1 MB of additional disk space will be used.
Do you want to continue? [Y/n] Y

# ...no messages of note during install

```

## ran install command per melview [webpage](http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Melview)

Melview install failed w/out `python-setuptools` installed, which isn't noted on FSL's install page:
```bash
[14:52:09]-[stowler-local]-at-[rama]-in-[~/src.upstream.gitRepos/melview] on master
$ sudo python ./setup.py install
Traceback (most recent call last):
  File "./setup.py", line 1, in <module>
    from setuptools import setup, find_packages
ImportError: No module named setuptools
```

Installed python-setuptools:
```bash
[14:56:17]-[stowler-local]-at-[rama]-in-[~/src.upstream.gitRepos/melview] on master
$ sudo apt-get install python-setuptools
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following NEW packages will be installed:
  python-setuptools
0 upgraded, 1 newly installed, 0 to remove and 3 not upgraded.
Need to get 230 kB of archives.
After this operation, 830 kB of additional disk space will be used.
Get:1 http://us.archive.ubuntu.com/ubuntu/ trusty-updates/main python-setuptools all 3.3-1ubuntu2 [230 kB]
Fetched 230 kB in 0s (372 kB/s)
Selecting previously unselected package python-setuptools.
(Reading database ... 219345 files and directories currently installed.)
Preparing to unpack .../python-setuptools_3.3-1ubuntu2_all.deb ...
Unpacking python-setuptools (3.3-1ubuntu2) ...
Setting up python-setuptools (3.3-1ubuntu2) ...
```

Successful melview install now that `python-setuptools` is installed:
```bash
[14:56:37]-[stowler-local]-at-[rama]-in-[~/src.upstream.gitRepos/melview] on master
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
creating build/lib.linux-x86_64-2.7/fsl
copying fsl/__init__.py -> build/lib.linux-x86_64-2.7/fsl
copying fsl/melodic.py -> build/lib.linux-x86_64-2.7/fsl
copying fsl/caches.py -> build/lib.linux-x86_64-2.7/fsl
creating build/lib.linux-x86_64-2.7/melview
copying melview/__init__.py -> build/lib.linux-x86_64-2.7/melview
copying melview/melodic_traits.py -> build/lib.linux-x86_64-2.7/melview
copying melview/mv2fix.py -> build/lib.linux-x86_64-2.7/melview
creating build/bdist.linux-x86_64
creating build/bdist.linux-x86_64/egg
creating build/bdist.linux-x86_64/egg/fsl
copying build/lib.linux-x86_64-2.7/fsl/__init__.py -> build/bdist.linux-x86_64/egg/fsl
copying build/lib.linux-x86_64-2.7/fsl/melodic.py -> build/bdist.linux-x86_64/egg/fsl
copying build/lib.linux-x86_64-2.7/fsl/caches.py -> build/bdist.linux-x86_64/egg/fsl
creating build/bdist.linux-x86_64/egg/melview
copying build/lib.linux-x86_64-2.7/melview/__init__.py -> build/bdist.linux-x86_64/egg/melview
copying build/lib.linux-x86_64-2.7/melview/melodic_traits.py -> build/bdist.linux-x86_64/egg/melview
copying build/lib.linux-x86_64-2.7/melview/mv2fix.py -> build/bdist.linux-x86_64/egg/melview
byte-compiling build/bdist.linux-x86_64/egg/fsl/__init__.py to __init__.pyc
byte-compiling build/bdist.linux-x86_64/egg/fsl/melodic.py to melodic.pyc
byte-compiling build/bdist.linux-x86_64/egg/fsl/caches.py to caches.pyc
byte-compiling build/bdist.linux-x86_64/egg/melview/__init__.py to __init__.pyc
byte-compiling build/bdist.linux-x86_64/egg/melview/melodic_traits.py to melodic_traits.pyc
byte-compiling build/bdist.linux-x86_64/egg/melview/mv2fix.py to mv2fix.pyc
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
Writing /tmp/easy_install-VgD8Hu/tornado-4.2.1/setup.cfg
Running tornado-4.2.1/setup.py -q bdist_egg --dist-dir /tmp/easy_install-VgD8Hu/tornado-4.2.1/egg-dist-tmp-XGLIvw
no previously-included directories found matching 'docs/build'
warning: no files found matching 'tornado/test/README'
tornado/speedups.c:49:1: warning: function declaration isn’t a prototype [-Wstrict-prototypes]
 initspeedups() {
 ^
zip_safe flag not set; analyzing archive contents...
tornado.autoreload: module references __file__
tornado.testing: module references __file__
tornado.test.httpserver_test: module references __file__
tornado.test.web_test: module references __file__
tornado.test.template_test: module references __file__
tornado.test.options_test: module references __file__
tornado.test.locale_test: module references __file__
tornado.test.iostream_test: module references __file__
Adding tornado 4.2.1 to easy-install.pth file

Installed /usr/local/lib/python2.7/dist-packages/tornado-4.2.1-py2.7-linux-x86_64.egg
Searching for certifi
Reading https://pypi.python.org/simple/certifi/
Best match: certifi 2015.04.28
Downloading https://pypi.python.org/packages/source/c/certifi/certifi-2015.04.28.tar.gz#md5=12c7c3a063b2ff97a0f8291d8de41e8c
Processing certifi-2015.04.28.tar.gz
Writing /tmp/easy_install-mTK4WW/certifi-2015.04.28/setup.cfg
Running certifi-2015.04.28/setup.py -q bdist_egg --dist-dir /tmp/easy_install-mTK4WW/certifi-2015.04.28/egg-dist-tmp-WTfceJ
zip_safe flag not set; analyzing archive contents...
certifi.core: module references __file__
Adding certifi 2015.04.28 to easy-install.pth file

Installed /usr/local/lib/python2.7/dist-packages/certifi-2015.04.28-py2.7.egg
Searching for backports.ssl-match-hostname
Reading https://pypi.python.org/simple/backports.ssl_match_hostname/
Best match: backports.ssl-match-hostname 3.4.0.2
Downloading https://pypi.python.org/packages/source/b/backports.ssl_match_hostname/backports.ssl_match_hostname-3.4.0.2.tar.gz#md5=788214f20214c64631f0859dc79f23c6
Processing backports.ssl_match_hostname-3.4.0.2.tar.gz
Writing /tmp/easy_install-xZTJA0/backports.ssl_match_hostname-3.4.0.2/setup.cfg
Running backports.ssl_match_hostname-3.4.0.2/setup.py -q bdist_egg --dist-dir /tmp/easy_install-xZTJA0/backports.ssl_match_hostname-3.4.0.2/egg-dist-tmp-nz8Rxj
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
Searching for nibabel==2.0.1
Best match: nibabel 2.0.1
nibabel 2.0.1 is already the active version in easy-install.pth

Using /usr/lib/python2.7/dist-packages
Searching for matplotlib==1.3.1
Best match: matplotlib 1.3.1
Adding matplotlib 1.3.1 to easy-install.pth file

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
[15:00:14]-[stowler-local]-at-[rama]-in-[~/src.upstream.gitRepos/melview] on master
$ which melview | xargs ls -l
-rwxr-xr-x 1 root root 301 Aug 25 15:00 /usr/local/bin/melview

[15:06:11]-[stowler-local]-at-[rama]-in-[~/src.upstream.gitRepos/melview] on master
$ which mv2fix | xargs ls -l
-rwxr-xr-x 1 root root 299 Aug 25 15:00 /usr/local/bin/mv2fix
```

## launched melview and loaded classifications

From superficial inspection of a single run's FIX results it looks like melview works. (Tested over ssh).
