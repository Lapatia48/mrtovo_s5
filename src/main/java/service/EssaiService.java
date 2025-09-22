package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import entity.Essai;
import repository.EssaiRepository;

@Service
public class EssaiService {

    @Autowired
    private EssaiRepository essaiRepo;

    public void passerEnEssai(Integer idCandidat, Integer periode) {
        // Vérifier que le candidat n'est pas déjà en essai
        if (essaiRepo.existsByIdCandidat(idCandidat)) return;

        Essai essai = new Essai();
        essai.setIdCandidat(idCandidat);
        essai.setPeriode(periode != null ? periode : 3); // par défaut 3 mois

        essaiRepo.save(essai);
    }
}



       

