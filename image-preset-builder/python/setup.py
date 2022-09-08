from setuptools import setup

setup(
    name='preset',
    version='0.1.0',
    author='ishaileshmishra',
    author_email='ishaileshmishra@gmail.com',
    packages=['package_name', 'package_name.test'],
    scripts=['bin/script1', 'bin/script2'],
    url='http://pypi.python.org/pypi/preset/',
    license='LICENSE.txt',
    description='An awesome package that does something',
    long_description=open('README.txt').read(),
    install_requires=[
        "Django >= 1.1.1",
        "pytest",
    ],
)
