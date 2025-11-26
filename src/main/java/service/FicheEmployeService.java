package service;

import entity.FicheEmploye;
import repository.FicheEmployeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class FicheEmployeService {

    @Autowired
    private FicheEmployeRepository ficheEmployeRepository;

    public FicheEmploye getOrCreateFicheEmploye(Integer idEmploye) {
        Optional<FicheEmploye> fiche = ficheEmployeRepository.findByIdEmploye(idEmploye);
        return fiche.orElseGet(() -> {
            FicheEmploye nouvelleFiche = new FicheEmploye(idEmploye);
            return ficheEmployeRepository.save(nouvelleFiche);
        });
    }

    
    public void updateTelephone(Integer idEmploye, String telephone) {
        FicheEmploye fiche = getOrCreateFicheEmploye(idEmploye);
        fiche.setTelephone(telephone);
        ficheEmployeRepository.save(fiche);
    }


    public void updatePhoto(Integer idEmploye, String photoUrl) {
        // Trouve ou crée une fiche pour cet employé
        FicheEmploye fiche = ficheEmployeRepository.findByIdEmploye(idEmploye)
                .orElse(new FicheEmploye(idEmploye));
        
        fiche.setPhotoUrl(photoUrl);
        ficheEmployeRepository.save(fiche);
        
        System.out.println("=== PHOTO UPDATÉE DANS TABLE: " + photoUrl);
    }

    public void ensureFicheExists(Integer idEmploye) {
        if (!ficheEmployeRepository.existsByIdEmploye(idEmploye)) {
            FicheEmploye nouvelleFiche = new FicheEmploye(idEmploye);
            ficheEmployeRepository.save(nouvelleFiche);
            System.out.println("=== FICHE CRÉÉE POUR EMPLOYÉ: " + idEmploye);
        }
    }

    // Autres méthodes update...
}