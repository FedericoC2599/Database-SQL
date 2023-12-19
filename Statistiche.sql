SELECT l.IDLibro, l.Titolo, MIN(cm.DataInizioLettura)
FROM Libri l 
JOIN CompletamentiLibri cl ON cl.IDLibro = l.IDLibro
JOIN Completamenti c ON c.IDCompletamento = cl.IDCompletamento