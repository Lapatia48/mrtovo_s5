package service;
import entity.CandidatDetailsView;
import repository.CandidatDetailsViewRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CandidatDetailsViewService {

    @Autowired
    private CandidatDetailsViewRepository repository;

        public List<CandidatDetailsView> getAllCandidats() {
                return repository.findAll();
        }

        public List<CandidatDetailsView> filterAndSort(
            String nom,
            String diplome,
            String departement,
            String ageOrder,
            String experienceOrder,
            String datePostuleOrder) {

        return repository.findAll()
                .stream()
                // 🔎 Filtre sur le nom : insensible à la casse, partiel
                .filter(c -> nom == null || nom.isEmpty() ||
                        c.getNom().toLowerCase().contains(nom.toLowerCase()))
                // 🔎 Filtre sur le diplôme
                .filter(c -> diplome == null || diplome.isEmpty() ||
                        (c.getDiplome() != null && c.getDiplome().equalsIgnoreCase(diplome)))
                // 🔎 Filtre sur le département
                .filter(c -> departement == null || departement.isEmpty() ||
                        (c.getDepartement() != null && c.getDepartement().equalsIgnoreCase(departement)))
                // 🔃 Tri combiné
                .sorted((c1, c2) -> {
                    int result = 0;

                    // 1️⃣ Tri par âge
                    if (ageOrder != null && !ageOrder.isEmpty()) {
                        result = "asc".equalsIgnoreCase(ageOrder)
                                ? c1.getAge().compareTo(c2.getAge())
                                : c2.getAge().compareTo(c1.getAge());
                    }

                    // 2️⃣ Tri par expérience si égalité
                    if (result == 0 && experienceOrder != null && !experienceOrder.isEmpty()) {
                        result = "asc".equalsIgnoreCase(experienceOrder)
                                ? c1.getAnneeExperience().compareTo(c2.getAnneeExperience())
                                : c2.getAnneeExperience().compareTo(c1.getAnneeExperience());
                    }

                    // 3️⃣ Tri par date de postule si encore égalité
                    if (result == 0 && datePostuleOrder != null && !datePostuleOrder.isEmpty()) {
                        result = "asc".equalsIgnoreCase(datePostuleOrder)
                                ? c1.getDatePostule().compareTo(c2.getDatePostule())
                                : c2.getDatePostule().compareTo(c1.getDatePostule());
                    }

                    return result;
                })
                .collect(Collectors.toList());
    }
}
