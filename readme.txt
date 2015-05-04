Instructiuni

Ubuntu:

1. Clonati repository-ul curent
2. instalati vagrant cu virtual box 
"apt-get install virtualbox vagrant"
3. Daca nu aveti instalat NFS 
"apt-get install nfs-kernel-server"
4. adaugati in fisierul hosts "192.168.56.101 intern-dev.local"
5. vagrant up
6. vagrant ssh
7. in ssh-ul de la vagrant:
7.1. "wget get.typo3.org/current" > copiati sursa typo3
7.2. "tar -xf current" > dezarhivati typo3-ul
7.3. "ln -s typo3_src-7.2.0 typo3_src" / "ln -s typo3_src/typo3 typo3" / "ln - s typo3_src/index.php index.php" > creati symlink-urile 