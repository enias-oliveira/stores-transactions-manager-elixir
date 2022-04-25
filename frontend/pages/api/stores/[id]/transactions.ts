// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
import axios from 'axios'
import type { NextApiRequest, NextApiResponse } from 'next'

type Data = {
    name: string
}

export default async function handler(
    req: NextApiRequest,
    res: NextApiResponse<Data>
) {
    const { id } = req.query;
    const transactions = await axios.get(`http://localhost:5500/stores/${id}/transactions`).then(res => res.data)
    res.status(200).json(transactions)
}
