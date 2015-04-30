Instructiuni

1. Clonati vagrant [done]
2. * vagrant up
3. * vagrant ssh
4. in ssh-ul de la vagrant:
4.1. "wget get.typo3.org/current" > copiati sursa typo3
4.2. "tar -xf current" > dezarhivati typo3-ul
4.3. "ln -s typo3_src-7.2.0 typo3_src" / "ln -s typo3_src/typo3 typo3" / "ln - s typo3_src/index.php index.php" > creati symlink-urile
5. adaugati in fisierul hosts "192.168.56.101 intern-dev.local"

* - se ruleaza din git bash