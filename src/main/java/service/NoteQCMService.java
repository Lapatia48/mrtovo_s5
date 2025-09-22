// package service;

// import entity.NoteQcm;
// import repository.NoteQcmRepository;
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Service;

// import java.util.List;
// import java.util.Optional;

// @Service
// public class NoteQcmService {

//     @Autowired
//     private NoteQcmRepository noteQcmRepository;

//     public List<NoteQCM> getAllNotes() { return noteQCMRepository.findAll(); }
//     public Optional<NoteQCM> getNoteById(Integer id) { return noteQCMRepository.findById(id); }
//     public List<NoteQCM> getNotesByCandidat(Integer idCandidat) { return noteQCMRepository.findByIdCandidat(idCandidat); }
//     public NoteQCM saveNote(NoteQCM noteQCM) { return noteQCMRepository.save(noteQCM); }
//     public void deleteNote(Integer id) { noteQCMRepository.deleteById(id); }
// }
