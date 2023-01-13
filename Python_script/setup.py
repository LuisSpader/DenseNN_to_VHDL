from setuptools import setup, find_packages

classifiers = [
    'Development Status :: Modularizando script Python_vhd_script & corrigindo script Python_make_NN'
    'Intended Audience :: me'
    'Operating System :: Microsoft :: Windows :: Windows 10'
    'License :: OSI Approved :: MIT License'
    'Programming Language :: Python :: 3'
]

setup(
    name='NN Scripts',
    version='0.1',
    description='Scripts para geração de vhdl através de  linguagem Python',
    long_description=open('README.txt').read() + '\n\n' +
    open('CHANGELOG.txt').read(),
    url='',
    author='Luis Antonio Spader Simon',
    author_email='luisspaders@gmail.com',
    license='MIT',
    classifiers=classifiers,
    keywords='',
    packages=find_packages(),
    install_requires=['']

)
