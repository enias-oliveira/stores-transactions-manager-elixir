import nextConnect from 'next-connect';
import { NextApiRequest, NextApiResponse } from 'next';
import formidable from 'formidable';
import axios from 'axios';
import FormData from 'form-data'
import { createReadStream } from 'fs';

const apiRoute = nextConnect<NextApiRequest, NextApiResponse>({
  onError(error, _req, res) {
    res.status(501).json({ error: `Sorry something Happened! ${error.message}` });
  },
  onNoMatch(req, res) {
    res.status(405).json({ error: `Method '${req.method}' Not Allowed` });
  },
});

apiRoute.post((req, res) => {
  const form = formidable({ keepExtensions: true, });
  form.parse(req, async (err, _fields, { file }) => {
    if (err) {
      throw err
    }
    const [newFile] = file as formidable.File[];
    const newFileStream = createReadStream(newFile.filepath);
    const formData = new FormData;
    formData.append('file', newFileStream, newFile.originalFilename || 'file.txt')

    await axios.post('http://localhost:5500/transactions/upload', formData, {
      headers: formData.getHeaders(),
    });

    res.status(200).json({ data: 'success' });
  });

});

export default apiRoute;

export const config = {
  api: {
    bodyParser: false,
  },
};
