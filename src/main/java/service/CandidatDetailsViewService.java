package service;
import entity.CandidatDetailsView;
import repository.CandidatDetailsViewRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.pdf.PdfWriter;


import java.io.FileOutputStream;
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


    public String toPdf(Integer id) {
        // Récupérer le candidat depuis la vue
        CandidatDetailsView cand = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Candidat introuvable avec id=" + id));

        try {
            // Nom du fichier (cvCandX.pdf)
            String fileName = "cvCand" + cand.getId() + ".pdf";

            // Création du document
            Document document = new Document(PageSize.A4);
            PdfWriter.getInstance(document, new FileOutputStream(fileName));
            document.open();

            // Style des titres
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16, BaseColor.BLUE);
            Font subTitleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 13, BaseColor.DARK_GRAY);
            Font textFont = FontFactory.getFont(FontFactory.HELVETICA, 12, BaseColor.BLACK);

            // === Titre principal ===
            Paragraph titre = new Paragraph("Curriculum Vitae", titleFont);
            titre.setAlignment(Element.ALIGN_CENTER);
            titre.setSpacingAfter(20);
            document.add(titre);

            // === Infos personnelles ===
            document.add(new Paragraph("Informations Personnelles", subTitleFont));
            document.add(new Paragraph("Nom : " + cand.getNom(), textFont));
            document.add(new Paragraph("Prénom : " + cand.getPrenom(), textFont));
            document.add(new Paragraph("Email : " + cand.getMail(), textFont));
            document.add(new Paragraph("Adresse : " + cand.getAdresse(), textFont));
            document.add(new Paragraph("Date de naissance : " + cand.getDateNaissance(), textFont));
            document.add(new Paragraph("Âge : " + cand.getAge() + " ans", textFont));
            document.add(Chunk.NEWLINE);

            // === Parcours professionnel ===
            document.add(new Paragraph("Parcours Professionnel", subTitleFont));
            document.add(new Paragraph("Département (poste) : " + cand.getDepartement(), textFont));
            document.add(new Paragraph("Années d'expérience : " + cand.getAnneeExperience(), textFont));
            document.add(new Paragraph("Diplôme : " + cand.getDiplome(), textFont));
            document.add(new Paragraph("Date de postulation : " + cand.getDatePostule(), textFont));
            document.add(Chunk.NEWLINE);

            // === Autres infos ===
            document.add(new Paragraph("Autres Informations", subTitleFont));
            document.add(new Paragraph("Renseignement : " + cand.getRenseignement(), textFont));
            document.add(Chunk.NEWLINE);

            // Pied de page
            Paragraph footer = new Paragraph("Fait le - " + java.time.LocalDate.now(), 
                                             FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 10, BaseColor.GRAY));
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);

            document.close();

            return fileName; // Retourne le chemin du fichier généré

        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de la génération du PDF : " + e.getMessage(), e);
        }
    }
}
